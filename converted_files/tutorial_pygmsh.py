#!/usr/bin/env python
# coding: utf-8

# # Mesh generation and conversion for DOLFIN and DOLFIN-X

# In this tutorial, you will learn:
# 1. [How to create a mesh with mesh markers in pygmsh](#first)
# 2. [How to create 3D meshes with pygmsh](#second)
# 3. [How to create an XDMF-file than can be imported in either dolfin or dolfinx](#third)
# 
# 
# Prerequisites for this tutorial is to install pygmsh[>=6.1.1](https://pypi.org/project/pygmsh/6.1.1/), meshio[>=4.1.1](https://pypi.org/project/meshio/4.1.1/) and gmsh[>=4.6.0](https://gmsh.info/bin/Linux/gmsh-4.6.0-Linux64.tgz). All of these dependencies can be found in the docker image
# `dolfinx/dev-env`, which can be ran on any computer with docker using
# ```bash
# docker run -ti -v $(pwd):/home/shared -w /home/shared --rm dolfinx/dev-env
# ```
# ## <a name="first"></a> 1. How to create a mesh with pygmsh
# In this tutorial, we will learn how to create a channel with a circular obstacle, as used in the [DFG-2D 2 Turek benchmark](http://www.featflow.de/en/benchmarks/cfdbenchmarking/flow/dfg_benchmark2_re100.html).
# 
# To do this, we use pygmsh.
# First we create an empty geometry and the circular obstacle:

# In[1]:


from pygmsh.built_in.geometry import Geometry
resolution = 0.01

# Channel parameters
L = 2.2
H = 0.41
c = [0.2, 0.2, 0]
r = 0.05

# Initialize empty geometry and create circular object
geometry = Geometry()
circle = geometry.add_circle(c, r, lcar=resolution)


# The next step is to create the channel with the circle as a hole.

# In[2]:


# Add points with finer resolution on left side
points = [geometry.add_point((0, 0, 0), lcar=resolution),
          geometry.add_point((L, 0, 0), lcar=5*resolution),
          geometry.add_point((L, H, 0), lcar=5*resolution),
          geometry.add_point((0, H, 0), lcar=resolution)]

# Add lines between all points creating the rectangle
channel_lines = [geometry.add_line(points[i], points[i+1])
                 for i in range(-1, len(points)-1)]

# Create a line loop and plane surface for meshing
channel_loop = geometry.add_line_loop(channel_lines)
plane_surface = geometry.add_plane_surface(
    channel_loop, holes=[circle.line_loop])


# The final step before mesh generation is to mark the different boundaries and the volume mesh. Note that with pygmsh, boundaries with the same tag has to be added simultaneously. In this example this means that we have to add the top and 
#  bottom wall in one function call. 

# In[3]:


volume_marker = 6
geometry.add_physical([plane_surface], 6)
inflow = 1
geometry.add_physical([channel_lines[0]], inflow)
outflow = 2
geometry.add_physical([channel_lines[2]], outflow)
walls = 3
geometry.add_physical([channel_lines[1], channel_lines[3]], walls)
obstacle = 4
geometry.add_physical(circle.line_loop.lines, obstacle)


# We generate the mesh using the pygmsh function `generate_mesh`. We add the keyword argument `geo_filename="mesh.geo"` to be able to inspect the mesh in the gmsh GUI, and `prune_z_0=True` to remove the z-coordinate from the mesh.
# To use this mesh in [the third tutorial](#third), one can add `msh_filename="mesh.msh"`. The output messages of gmsh has been supressed with `verbose=False`.

# In[4]:


from pygmsh import generate_mesh
mesh = generate_mesh(
        geometry, prune_z_0=True,
        geo_filename="mesh.geo", msh_filename="mesh.msh", verbose=False)


# The full script for this code can be downloaded [here](../converted_files/tutorial_pygmsh.py).
# ## <a name="second"></a>2. How to create a 3D mesh using pygmsh
# To create more advanced meshes, such as 3D geometries, using the OpenCASCADE geometry kernel is recommended.
# We start by importing this kernel, and creating three objects:
# - A box $[0,0,0]\times[1,1,1]$
# - A box $[0.5,0.0.5,1]\times[1,1,2]$
# - A ball from $[0.5,0.5,0.5]$ with radius $0.25$.

# In[5]:


import pygmsh.opencascade as opencascade
char_length = 0.1
geom = opencascade.Geometry()
box0 =  geom.add_box([0.0, 0, 0], [1, 1, 1], char_length=char_length)
box1 =  geom.add_box([0.5, 0.5, 1], [0.5, 0.5, 1], char_length=char_length)
ball = geom.add_ball([0.5, 0.5, 0.5], 0.25, char_length=char_length)


# In this demo, we would like to make a mesh that is the union of these three objects. 
# In addition, we would like the internal boundary of the sphere to be preserved in the final mesh.
# We will do this by using boolean operations. First we make a `boolean_union` of the two boxes (whose internal boundaries will not be preserved). Then, we use boolean fragments to perserve the outer boundary of the sphere.

# In[6]:


union = geom.boolean_union([box0, box1])
union_minus_ball = geom.boolean_fragments([union],[ball])


# To create physical markers for the two regions, we use the `add_physical` function. This function only works nicely if the domain whose boundary should be preserved (the sphere) is fully embedded in the other domain (the union of boxes). For more complex operations, it is recommened to do the tagging of entities in the gmsh GUI.

# In[7]:


geom.add_physical(union, 1)
geom.add_physical(union_minus_ball, 2)


# We finally generate the 3D mesh, and save both the geo and  msh file as in the previous example.

# In[8]:


mesh3D = generate_mesh(geom, geo_filename="mesh3D.geo", msh_filename="mesh3D.msh",
                      verbose=False)


# ## <a name="third"></a>3. How to load meshes into dolfin and dolfinx

# In this part of the tutorial, we will learn how to convert the meshes from the `msh` format or `pygmsh` format, into an `XDMF`-format that  is compatible with `dolfin` and `dolfinx`.
# 
# We start by considering the two meshes returned by `pygmsh.generate_mesh`, namely `mesh` and `mesh3d`.
# These meshes contain cell data and possible facet data, which has to be separated to be used in dolfin/dolfinx. 
# We separate this with the following convience function

# In[9]:


import numpy
import meshio
def create_mesh(mesh, cell_type):
    cells = numpy.vstack([cell.data for cell in mesh.cells if cell.type==cell_type])
    data = numpy.hstack([mesh.cell_data_dict["gmsh:physical"][key]
                           for key in mesh.cell_data_dict["gmsh:physical"].keys() if key==cell_type])
    mesh = meshio.Mesh(points=mesh.points, cells={cell_type: cells},
                               cell_data={"name_to_read":[data]})
    return mesh


# Next we use this function on the 2D meshes, and write them to file as `mesh2D.xdmf` and `mf2D.xdmf`

# In[10]:


triangle_mesh = create_mesh(mesh, "triangle")
facet_mesh = create_mesh(mesh, "line")
meshio.write("mesh2D.xdmf", triangle_mesh)
meshio.write("mf2D.xdmf", facet_mesh)


# These XDMF-files  can be visualized in Paraview and looks like
# 
# ![The 2D mesh and the corresponding facet data visualized in Paraview](../assets/img/mesh2D.png)
# 
# The same strategy can be used on general `msh`-files, as shown below

# In[11]:


mesh3D_from_msh = meshio.read("mesh3D.msh")
tetra_mesh = create_mesh(mesh3D_from_msh, "tetra")
meshio.write("mesh3D_from_msh.xdmf", tetra_mesh)


# The 3D mesh can also be visualized in Paraview
# 
# ![3D mesh with cell markers in Paraview](../assets/img/mesh3D.png)

# In the next tutorial, you will learn how to use these XDMF-files in dolfin and dolfinx (To be released)
