![Image of J.S.Dokken](assets/img/cropped.jpg){: .image-left }

Welcome to my personal web-page. Here you can find information about me, and the projects I have been working on during my post-graduate studies.

# Latest news

## 2023

- **New preprint**: [DOLFINx: The next generation FEniCS problem solving environment](papers.md#dolfinx2023preprint) available at [DOI:10.5281/zenodo.10447666](https://doi.org/10.5281/zenodo.10447666)
- **New tutorial**: FEniCSx tutorial for students enrolled in the class MU5MES01 of the _Solid Mechanics Master of Sorbonne Université and ENPC_. The tutorial is available at [http://jsdokken.com/FEniCS23-tutorial/](http://jsdokken.com/FEniCS23-tutorial/)
- Presentation at d'Alembert institute on my research _Boundary condition extensions in FEniCSx_, See [the D'Alembert YouTube channel](https://www.youtube.com/watch?v=4LSWOdyiGH8) for the full presentation
- The presentation from [FEniCS 23](https://fenicsproject.org/fenics-2023/) on checkpointing is available at [checkpointing-presentation](https://www.jsdokken.com/checkpointing-presentation/#/). The code is available at [jorgensd/checkpointing-presentation](https://github.com/jorgensd/checkpointing-presentation/)
- **New paper published**: See: [https://joss.theoj.org/papers/10.21105/joss.05580#](https://joss.theoj.org/papers/10.21105/joss.05580#) for details
- A Python implementation for checkpointing in DOLFINx is available at [adios4dolfinx](https://github.com/jorgensd/adios4dolfinx)

## 2022

- A web resource for reproducible research available at [scientificcomputing@github](https://scientificcomputing.github.io/)
- [Construction of arbitrary order finite element degree-of-freedom maps on polygonal and polyhedral cell meshes](papers.md#scroggs2022dofs) open-access publication at [TOMS](https://doi.org/10.1145/3524456).
- The [DOLFINx tutorial](https://jorgensd.github.io/dolfinx-tutorial/) v0.4.1 has been released.
- [TEAM 30 Benchmark](http://www.compumag.org/jsite/images/stories/TEAM/problem30a.pdf) of electromagnetic a 2D induction engine available at [Github (Wells-group/TEAM30)](https://github.com/Wells-Group/TEAM30)

## 2021

- Proceedings of the [FEniCS 2021](https://mscroggs.github.io/fenics2021)-conference is available [here](https://figshare.com/articles/conference_contribution/Proceedings_of_FEniCS_2021_22_26_March_2021/14495856).
- Simple Taylor-Green solver and [3D Turek benchmark](http://www.featflow.de/en/benchmarks/cfdbenchmarking/flow/dfg_flow3d.html) IPCS Navier-Stokes solver for [dolfinx](https://github.com/FEniCS/dolfinx/) is available at [jorgensd/dokken_ipcs](https://github.com/jorgensd/dolfinx_ipcs) on Github!

<br style="clear:both">

# About me

I am currently employed at [Simula Research Laboratory](https://www.simula.no/people/dokken) as a Senior Research Engineer. I am also one of the administrators of the [FEniCS Discourse forum](https://fenicsproject.discourse.group/) and I am member of the [FEniCS Steering Council](https://github.com/FEniCS/governance/blob/master/governance.md#steering-council).

From 2019-2022 I worked as a Postdoctoral Research Associate at the University of Cambridge, working on the ASiMoV project, working with [Chris Richardson](http://www.bpi.cam.ac.uk/user/chris) and [Garth Wells](http://www3.eng.cam.ac.uk/~gnw20/) on the [ASiMoV](https://gow.epsrc.ukri.org/NGBOViewGrant.aspx?GrantRef=EP/S005072/1)-project. The main goal of this project was to do the worlds first, high fidelity simulation of a complete gas-turbine engine during operation, simultaneously including the effects of thermo-mechanics, electromagnetics, and CFD. My main focus during this project was contact mechanics, multi-point constraints and large scale simulations with MPI.

From 2016-2019 I took my PhD at Simula Research Laboratory on the subject of Shape Optimization with Finite Element Methods.

<br style="clear:both">

## Software

I am involved in the development of the following software:
![The FEniCS logo](assets/img/fenics_logo.png){: .image-right }

- [The FEniCS project](https://bitbucket.org/fenics-project/) - An open-source computing platform for solving partial differential equations using the finite element method. End-user and core development resulting in the following papers and preprints

  - [DOLFINx: The next generation FEniCS problem solving environment](papers.md#dolfinx2023preprint)
  - [Construction of arbitrary order finite element degree-of-freedom maps on polygonal and polyhedral cell meshes](papers.md#scroggs2022dofs)
  - [A multimesh finite element method for the Navier--Stokes equations based on projection methods](papers.md#dokken2020navier)
  - [Shape Optimization Using the Finite Element Method on Multiple Meshes with Nitsche Coupling](papers.md#dokken2019shape)

- [Dolfin-adjoint](https://dolfin-adjoint.github.io/dolfin-adjoint/) - An algorithmic differentiation tool using [pyadjoint](https://github.com/dolfin-adjoint/pyadjoint) to differentiate FEM models written in [Dolfin](https://bitbucket.org/fenics-project/dolfin/src/master/) and [Firedrake](https://www.firedrakeproject.org/). The contributions here have resulted in the following papers and preprints
  - [Automatic shape derivatives for transient PDEs in FEniCS and Firedrake](papers.md#dokken2020shape)
  - [dolfin-adjoint 2018.1: automated adjoints for FEniCS and Firedrake](papers.md#mitusch2019pyadjoint)
- [Scientific Computing @ Simula](https://scientificcomputing.github.io/) A web resource for best software practices for academics using Python
- [dolfinx_mpc](https://github.com/jorgensd/dolfinx_mpc) - An extension to DOLFINx supporting multi-point constraints (such as contact and slip conditions)
