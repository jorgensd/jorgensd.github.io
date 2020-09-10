---
title: Create a simple mesh with markers using pygmsh
---

In this tutorial, you will learn:
1. How to create a mesh with pygmsh
2. How to create mesh markers for built in geometries
3. How to create an XDMF-file than can be imported in either dolfin or dolfinx
4. How to load existing "msh"-files into dolfin and dolfinx

Prerequisites for this tutorial is to install `pygmsh` ([>=v 6.1.1](https://pypi.org/project/pygmsh/6.1.1/)), `meshio` ([>=v 4.1.1](https://pypi.org/project/meshio/4.1.1/)) and `gmsh` ([>=v 4.6.0](https://gmsh.info/bin/Linux/gmsh-4.6.0-Linux64.tgz)). All of these dependencies can be found in the docker image
`dolfinx/dev-env`, which can be ran on any computer with docker using
```
docker run -ti -v $(pwd):/home/shared -w /home/shared --rm dolfinx/dev-env
```

## 1. How to create a mesh with pygmsh

