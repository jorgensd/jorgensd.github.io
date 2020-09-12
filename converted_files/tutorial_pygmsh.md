# PYGMSH with DOLFIN and DOLFIN-X

In this tutorial, you will learn:
1. How to create a mesh with mesh markers in pygmsh
2. How to create 3D meshes with pygmsh (For now see this [discourse reply](https://fenicsproject.discourse.group/t/pygmsh-tutorial/2506/8?u=dokken)
3. How to create an XDMF-file than can be imported in either dolfin or dolfinx
4. How to load existing "msh"-files into dolfin and dolfinx

Prerequisites for this tutorial is to install pygmsh[>=6.1.1](https://pypi.org/project/pygmsh/6.1.1/), meshio[>=4.1.1](https://pypi.org/project/meshio/4.1.1/) and gmsh[>=4.6.0](https://gmsh.info/bin/Linux/gmsh-4.6.0-Linux64.tgz). All of these dependencies can be found in the docker image
`dolfinx/dev-env`, which can be ran on any computer with docker using
```bash
docker run -ti -v $(pwd):/home/shared -w /home/shared --rm dolfinx/dev-env
```
## 1. How to create a mesh with pygmsh
In this tutorial, we will learn how to create a channel with a circular obstacle, as used in the [DFG-2D 2 Turek benchmark](http://www.featflow.de/en/benchmarks/cfdbenchmarking/flow/dfg_benchmark2_re100.html).

To do this, we use pygmsh.
First we create an empty geometry and the circular obstacle:


```python
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
```

The next step is to create the channel with the circle as a hole.


```python
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
```

The final step before mesh generation is to mark the different boundaries and the volume mesh. Note that with pygmsh, boundaries with the same tag has to be added simultaneously. In this example this means that we have to add the top and 
 bottom wall in one function call. 


```python
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
```

We generate the mesh using the pygmsh function `generate_mesh`. We add the keyword argument `geo_filename="mesh.geo"` to be able to inspect the mesh in the gmsh GUI, and `prune_z_0=True` to remove the z-coordinate from the mesh.
To use this mesh in [the third tutorial](#third), one can add `msh_filename="mesh.msh"`


```python
from pygmsh import generate_mesh
mesh = generate_mesh(
        geometry, prune_z_0=True,
        geo_filename="mesh.geo", msh_filename="mesh.msh")
```

    Info    : Running 'gmsh -3 mesh.geo -format msh -bin -o mesh.msh' [Gmsh 4.6.0, 1 node, max. 1 thread]
    Info    : Started on Sat Sep 12 14:59:11 2020
    Info    : Reading 'mesh.geo'...
    Info    : Done reading 'mesh.geo'
    Info    : Meshing 1D...
    Info    : [  0%] Meshing curve 1 (Circle)
    Info    : [ 20%] Meshing curve 2 (Circle)
    Info    : [ 30%] Meshing curve 3 (Circle)
    Info    : [ 50%] Meshing curve 6 (Line)
    Info    : [ 60%] Meshing curve 7 (Line)
    Info    : [ 80%] Meshing curve 8 (Line)
    Info    : [ 90%] Meshing curve 9 (Line)
    Info    : Done meshing 1D (Wall 0.00851607s, CPU 0.008s)
    Info    : Meshing 2D...
    Info    : [  0%] Meshing surface 5 (Plane, Frontal-Delaunay)
    Info    : [ 50%] Meshing surface 11 (Plane, Frontal-Delaunay)
    Info    : Done meshing 2D (Wall 0.0718801s, CPU 0.068s)
    Info    : Meshing 3D...
    Info    : Done meshing 3D (Wall 3.48091e-05s, CPU 0s)
    Info    : 2699 nodes 5435 elements
    Info    : Writing 'mesh.msh'...
    Info    : Done writing 'mesh.msh'
    Info    : Stopped on Sat Sep 12 14:59:11 2020 (From start: Wall 0.0836709s, CPU 0.124s)
    
    msh file: mesh.msh
    
    geo file: mesh.geo


The full script for this code can be downloaded [here](tutorial_pygmsh.py).

## <a name="third"></a>3. How to load existing "msh"-files into dolfin and dolfinx


```python

```