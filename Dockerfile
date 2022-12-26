# This is a Dockerfile used to install dependencies for my webpage
#
# Authors:
# Jørgen S. Dokken <dokken92@gmail.com>

FROM ubuntu:22.04

WORKDIR /tmp

ARG MPI="mpich"
ARG MAKEFLAGS
ARG GMSH_VERSION="4.11.1"
ARG PYGMSH_VERSION="7.1.17"
ARG MESHIO_VERSION="5.3.4"

ENV HDF5_MPI="ON"
ENV HDF5_DIR="/usr/lib/x86_64-linux-gnu/hdf5/mpich/"

# First dependencies are general dependencies
# Second set are GMSH deps
# Third set is meshio deps
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -qq update && \
    apt-get -yq --with-new-pkgs -o Dpkg::Options::="--force-confold" upgrade && \
    apt-get -y install \
    python3-dev \
    libhdf5-${MPI}-dev \
    lib${MPI}-dev \
    pkg-config \
    libxft2 \
    python3-pip &&\
    apt-get -y install \
    doxygen \
    git \
    graphviz \
    sudo \
    valgrind \
    wget && \
    apt-get -y install \
    libglu1 \
    libxcursor-dev \
    libxinerama1 \
    libgl-dev \
    libxft2 && \
    apt-get -y install \
    python3-lxml && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN CC=mpicc python3 -m pip install --no-cache-dir --no-binary=h5py h5py
RUN python3 -m pip install meshio

# Meshio python deps via pip
RUN python3 -m pip install pygmsh==${PYGMSH_VERSION} mpi4py && \
    python3 -m pip install gmsh==${GMSH_VERSION}

ENV PATH=$PATH:/usr/local/bin
ENV PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.10/site-packages/gmsh-${GMSH_VERSION}-Linux64-sdk/lib/
WORKDIR /root

# Install jupytext
RUN python3 -m pip install jupytext

# Activate for jupter notebook
RUN python3 -m pip install --upgrade --no-cache-dir jupyter jupyterlab
EXPOSE 8888/tcp
ENV SHELL /bin/bash

ENTRYPOINT ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root"]