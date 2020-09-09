---
title: About me
---

I am currently a Postdoctoral Research Associate at the University of Cambridge, working on the ASiMoV project, working with [Chris Richardson](http://www.bpi.cam.ac.uk/user/chris) and [Garth Wells](http://www3.eng.cam.ac.uk/~gnw20/) on the [ASiMoV](https://gow.epsrc.ukri.org/NGBOViewGrant.aspx?GrantRef=EP/S005072/1)-project. The main goal of this projecct is to do the worlds first, high fidelity simulation of a complete gas-turbine engine during operation, simultaneously including the effects of thermo-mechanics, electromagnetics, and CFD.

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
