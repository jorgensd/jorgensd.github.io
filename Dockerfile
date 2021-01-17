# This is a Dockerfile used to install dependecies for my webpage
#
# Authors:
# Jørgen S. Dokken <dokken92@gmail.com>

FROM ubuntu:20.04 as pygmsh-env

WORKDIR /tmp

ARG MPI="mpich"
ARG MAKEFLAGS

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
    libxft2 && \
    apt-get -y install \
    python3-lxml && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Meshio python deps via pip
RUN pip3 install mpi4py pygmsh && \
    pip3 install gmsh --user
RUN export export HDF5_MPI="ON" && \
    export HDF5_DIR="/usr/lib/x86_64-linux-gnu/hdf5/mpich/" && \
    export CC=mpicc && \ 
    pip3 install --no-cache-dir --no-binary=h5py h5py meshio 

RUN pip3 install ipython

ENV PATH=$PATH:/root/.local/bin
ENV PYTHONPATH=$PYTHONPATH:/root/.local/lib/python3.8/site-packages/gmsh-4.7.1-Linux64-sdk/lib/
WORKDIR /root
