# Using the GMSH Python API to generate complex meshes
In this tutorial, we will use the gmsh API to generate complex meshes. We will in this tutorial learn how to make the 3D mesh used in the [DFG 3D laminar benchmark](http://www.featflow.de/en/benchmarks/cfdbenchmarking/flow/dfg_flow3d.html). The [first part](first) of this tutorial can be completed with the `dokken92/pygmsh-6.1.1` docker images, as described in the [pygmsh tutorial](converted_files/tutorial_pygmsh.md). For the [second](second) and [third](third) part of the tutorial, `dolfinx` is required. You can obtain a jupter-lab image with `dolfinx/lab` and a normal docker image with `dolfinx/dolfinx`.

## <a name="first"></a> 1. How to create a 3D mesh with physical tags with the GMSH python API.
We start by import the gmsh module, and initializing the Python API. **NOTE:** This has to be done in order to run any function in the GMSH API.


```python
import gmsh
gmsh.initialize()
```

The next step is to create the rectangular channel of the benchmark. In GMSH, there are two kernels for geometry computations; the `built_in` kernel ( `gmsh.model.geo`), and the [OpenCascade](https://www.opencascade.com/) kernel (`gmsh.model.opencascade`). In this tutorial, we will use the the `occ` kernel, as it is better suited. Other demos of the usage of the gmsh python API can be found in their [GitLab repository](https://gitlab.onelab.info/gmsh/gmsh/-/tree/master/tutorial/python).


```python
gmsh.model.add("DFG 3D")
channel = gmsh.model.occ.addBox(0, 0, 0, 2.5, 0.41, 0.41)
```

The next step is to create the cylinder, which is done in the following way


```python
cylinder = gmsh.model.occ.addCylinder(0.5, 0,0.2,0, 0.41, 0, 0.05)
```

where the first three arguments describes the (x,y,z) coordinate of the center of the first circular face. The next three arguments describes the axis of height of the cylinder, in this case, it is (0,0.41,0). The final parameter is the radius of the cylinder.
We have now created two geometrical objects, that each can be meshed with GMSH. However, we are only interested in the fluid volume in the channel, which whould be the channel excluding the sphere. We use the GMSH command `BooleanDifference` for this


```python
fluid = gmsh.model.occ.cut([(3, channel)], [(3, cylinder)])
```

where the first argument `[(3, channel)]`is a list of tuples, where the first argument is the geometrical dimension of the entity (Point=0, Line=1, Surface=2, Volume=3). and channel is a unique integer identifying the channel. Similarly, the second argument is the list of tuples of entities we would like to exclude from 
the newly created fluid volume.
The next step is to tag physical entities, such as the fluid volume, and inlets, outlets, channel walls and obstacle walls.
We start by finding the volumes, which after the `cut`-operation is only the fluid volume. We could have kept the other volumes by supply keyword arguments to the  `cut`operation. See the [GMSH Python API](https://gitlab.onelab.info/gmsh/gmsh/-/blob/master/api/gmsh.py#L5143) for more information.


```python
volumes = gmsh.model.getEntities(dim=3)
assert(volumes == fluid[0])
print(volumes)
fluid_marker = 11
gmsh.model.addPhysicalGroup(volumes[0][0], [volumes[0][1]], fluid_marker)
gmsh.model.setPhysicalName(volumes[0][0], fluid_marker, "Fluid volume")
```

    [(3, 1)]


Before meshing the model, we need to use the syncronize command


```python
gmsh.model.occ.synchronize()
gmsh.model.mesh.generate(3)
gmsh.write("test.msh")
```

## <a name="second"></a> 2. How to load this mesh into dolfin-X without IO

## <a name="third"></a> 3. How to load msh files into dolfin-X


```python

```
