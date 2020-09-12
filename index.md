![Image of J.S.Dokken](assets/img/cropped.jpg){: .image-left }

Welcome to my personal web-page. Here you can find information about me, and the projects I have been working on during my post-graduate studies.

# Latest news
- A simple tutorial for usage of pygmsh has been added to the [Tutorial pages](converted_files/tutorial_pygmsh.md).
- Simple Taylor-Green solver and [3D Turek benchmark](http://www.featflow.de/en/benchmarks/cfdbenchmarking/flow/dfg_flow3d.html) IPCS Navier-Stokes solver for [dolfinx](https://github.com/FEniCS/dolfinx/) is available at [jorgensd/dokken_ipcs](https://github.com/jorgensd/dolfinx_ipcs) on Github!

<br style="clear:both">

# About me

<figure class="image" style="float:left;padding-right:10px;width:300px">
  <img src="https://s0.geograph.org.uk/geophotos/05/02/43/5024302_a15fb90d.jpg" style="width:300px" alt="Cambridge Engineering Department">
  <figcaption style="width:300px">  © Copyright <a title="View profile" href="/profile/3101" xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName" rel="cc:attributionURL dct:creator">N Chadwick</a> and
licensed for <a href="/reuse.php?id=5024302" itemprop="acquireLicensePage">reuse</a> under this <a rel="license" itemprop="license" href="http://creativecommons.org/licenses/by-sa/2.0/" class="nowrap" about="https://s0.geograph.org.uk/geophotos/05/02/43/5024302_a15fb90d.jpg" title="Creative Commons Attribution-Share Alike 2.0 Licence">Creative Commons Licence</a>.</figcaption>
</figure>

I am currently a Postdoctoral Research Associate at the University of Cambridge, working on the ASiMoV project, working with [Chris Richardson](http://www.bpi.cam.ac.uk/user/chris) and [Garth Wells](http://www3.eng.cam.ac.uk/~gnw20/) on the [ASiMoV](https://gow.epsrc.ukri.org/NGBOViewGrant.aspx?GrantRef=EP/S005072/1)-project. The main goal of this projecct is to do the worlds first, high fidelity simulation of a complete gas-turbine engine during operation, simultaneously including the effects of thermo-mechanics, electromagnetics, and CFD.

<br style="clear:both">

## Software
I am involved in the development of the following software:
![The FEniCS logo](assets/img/fenics_logo.png){: .image-right }
- [dolfinx](https://github.com/FEniCS/dolfinx) - The next generation FEniCS problem solving environment
- [dolfinx_mpc](https://github.com/jorgensd/dolfinx_mpc)- An extension to Dolfin-X supporting multi-point constraints (such as contact and slip conditions)
- [The FEniCS project](https://bitbucket.org/fenics-project/) - An open-source computing platform for solving partial differential equations using the finite element method. My main focus in this software was the multimesh finite element method, resulting in the following papers:
  - [A multimesh finite element method for the Navier--Stokes equations based on projection methods](papers.md#dokken2020navier)
  - [Shape Optimization Using the Finite Element Method on Multiple Meshes with Nitsche Coupling](papers.md#dokken2019shape)
- [dolfin-adjoint](http://www.dolfin-adjoint.org/en/latest/) - An algorithmic differentiation tool using
    [pyadjoint](https://github.com/dolfin-adjoint/pyadjoint) to differentiate FEM models written in [Dolfin](https://bitbucket.org/fenics-project/dolfin/src/master/) and [Firedrake](https://www.firedrakeproject.org/). The contributions here have resulted in one published paper and one preprint
    - [Automatic shape derivatives for transient PDEs in FEniCS and Firedrake](papers.md#dokken2020shape)
    - [dolfin-adjoint 2018.1: automated adjoints for FEniCS and Firedrake](papers.md#mitusch2019pyadjoint)
