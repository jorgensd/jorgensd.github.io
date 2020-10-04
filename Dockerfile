# This is a Dockerfile used to install dependecies for my webpage
#
# Authors:
# Jørgen S. Dokken <dokken92@gmail.com>

FROM ubuntu:20.04 as pygmsh-env

WORKDIR /tmp

ARG GMSH_VERSION=4.6.0
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
    libxinerama1 && \
    apt-get -y install \
    python3-lxml && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Meshio python deps via pip
RUN export HDF5_MPI="ON" && \
    export CC=mpicc && \
	pip3 install mpi4py && \
    pip3 install --no-cache-dir --no-binary=h5py h5py meshio==4.1.1 pygmsh==6.1.1

RUN pip3 install ipython
# Download Install Gmsh SDK
RUN cd /usr/local && \
    wget -nc --quiet http://gmsh.info/bin/Linux/gmsh-${GMSH_VERSION}-Linux64-sdk.tgz && \
    tar -xf gmsh-${GMSH_VERSION}-Linux64-sdk.tgz && \
    rm gmsh-${GMSH_VERSION}-Linux64-sdk.tgz

# Add GMSH to pytho API
ENV PATH=/usr/local/gmsh-${GMSH_VERSION}-Linux64-sdk/bin:$PATH
ENV PYTHONPATH=/usr/local/gmsh-${GMSH_VERSION}-Linux64-sdk/lib:$PYTHONPATH

WORKDIR /root
