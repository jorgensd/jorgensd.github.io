![Image of J.S.Dokken](assets/img/cropped.jpg){: .image-left }

# About me

I am currently employed at [Simula Research Laboratory](https://www.simula.no/people/dokken) as a Senior Research Engineer.
I am also one of the administrators of the [FEniCS Discourse forum](https://fenicsproject.discourse.group/) and I am member of the [FEniCS Steering Council](https://github.com/FEniCS/governance/blob/master/governance.md#steering-council).
My focus is on finite element related software, usually extensions to the FEniCS project, or applications where FEniCS is employed.

From 2019-2022 I worked as a Postdoctoral Research Associate at the University of Cambridge, working on the ASiMoV project with Chris Richardson and Garth N. Wells on the [ASiMoV](https://gtr.ukri.org/projects?ref=EP%2FS005072%2F1#/tabOverview)-project.
The main goal of this project was to do the worlds first, high fidelity simulation of a complete gas-turbine engine during operation, simultaneously including the effects of thermo-mechanics, electromagnetics, and CFD.
My main focus during this project was contact mechanics, multi-point constraints and large scale simulations with MPI.

From 2016-2019 I took my PhD at Simula Research Laboratory on the subject of Shape Optimization with Finite Element Methods.

<br style="clear:both">

# Latest news

## 2025

- **New paper**: [The latent variable proximal point algorithm for variational problems with inequality constraints](papers.md#lvpp2025cmame) available at: [DOI: 10.1016/j.cma.2025.118181](https://doi.org/10.1016/j.cma.2025.118181) published in _Computer Methods in Applied Mechanics and Engineering_
- **New preprint**: [On the numerical evaluation of wall shear stress using the finite element method](papers.md#brunatova_wss_arxiv) available at: [DOI: 10.48550/arXiv.2501.02987](https://doi.org/10.48550/arXiv.2501.02987)

## 2024

- **New paper**: [Spatial modeling algorithms for reactions and transport in biological cells](papers.md#smart_nature) available at: [DOI: 10.1038/s43588-024-00745-x](https://doi.org/10.1038/s43588-024-00745-x). For a general summary see: [UCSD Research Alert](https://today.ucsd.edu/story/new-software-unlocks-secrets-of-cell-signaling)
- **October 21st-22nd**: Two-day DOLFINx workshop at the [MIT Plasma Science and Fusion Center](https://www.psfc.mit.edu/). The workshop material is available at [https://jsdokken.com/FEniCS-workshop](https://jsdokken.com/FEniCS-workshop).
- **October 4th,11th**: I will give two lectures as part of MU5MES01 of the Solid Mechanics of the Solid Mechanics Master of Sorbonne Université and ENPC. See [MU5MES01@Github](https://github.com/msolides-2024/MU5MES01-2024) for more information.
- **October 1st**: I will give an introduction to the FEniCS library at École des Ponts, Paris. See [Laboratory Navier](https://navier-lab.fr/agenda/seminaire-msa-jorgen-s-dokken/) for more information.
- I am organizing the FEniCS 24 conference at Simula Research Laboratory June 12th-14th in Oslo Norway. See: [https://fenicsproject.org/fenics-2024/](https://fenicsproject.org/fenics-2024/) for details
- v0.8.0 of the DOLFINx tutorial have been published
- **New paper published**: [https://joss.theoj.org/papers/10.21105/joss.06451](https://joss.theoj.org/papers/10.21105/joss.06451) for details
- Online panelist at the DOEPy meetup (April 24th), see: [The Python Exchange for DoE Employees](lectures.md#DoEPy) for the event recording details.

## Older news

- Older news can be found [here](older_news.md)

<br style="clear:both">

## Software

I am involved in the development of the following software:
![The FEniCS logo](assets/img/fenics_logo.png){: .image-right }

- [The FEniCS project](https://bitbucket.org/fenics-project/) - An open-source computing platform for solving partial differential equations using the finite element method.
  End-user and core development resulting in the following papers, software and preprints

  - [DOLFINx: The next generation FEniCS problem solving environment](papers.md#dolfinx2023preprint)
  - [FESTIM: An open-source code for hydrogen transport simulations](https://festim.readthedocs.io/en/latest/)
  - [SciFEM: Convenience tools and extensions to FEniCSx](https://scientificcomputing.github.io/scifem/)
  - [Construction of arbitrary order finite element degree-of-freedom maps on polygonal and polyhedral cell meshes](papers.md#scroggs2022dofs)
  - [A multimesh finite element method for the Navier--Stokes equations based on projection methods](papers.md#dokken2020navier)
  - [Shape Optimization Using the Finite Element Method on Multiple Meshes with Nitsche Coupling](papers.md#dokken2019shape)

- [Dolfin-adjoint](https://dolfin-adjoint.github.io/dolfin-adjoint/) - An algorithmic differentiation tool using [pyadjoint](https://github.com/dolfin-adjoint/pyadjoint) to differentiate FEM models written in [Dolfin](https://bitbucket.org/fenics-project/dolfin/src/master/) and [Firedrake](https://www.firedrakeproject.org/). The contributions here have resulted in the following papers and preprints
  - [Automatic shape derivatives for transient PDEs in FEniCS and Firedrake](papers.md#dokken2020shape)
  - [dolfin-adjoint 2018.1: automated adjoints for FEniCS and Firedrake](papers.md#mitusch2019pyadjoint)
- [Scientific Computing @ Simula](https://scientificcomputing.github.io/) A web resource for best software practices for academics using Python
- [dolfinx_mpc](https://github.com/jorgensd/dolfinx_mpc) - An extension to DOLFINx supporting multi-point constraints (such as contact and slip conditions)
- [adios4dolfinx](papers.md#adios4dolfinx)
