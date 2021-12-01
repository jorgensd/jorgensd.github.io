# This is a Dockerfile used to install dependecies for my webpage
#
# Authors:
# Jørgen S. Dokken <dokken92@gmail.com>

FROM ubuntu:21.10 as pygmsh-env

WORKDIR /tmp

ARG MPI="mpich"
ARG MAKEFLAGS
ARG GMSH_VERSION="4.8.4"
ARG PYGMSH_VERSION="7.1.13"
ARG MESHIO_VERSION="5.0.5"

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


RUN HDF5_MPI="ON" HDF5_DIR="/usr/lib/x86_64-linux-gnu/hdf5/mpich/" CC=mpicc pip3 install --no-cache-dir --no-binary=h5py h5py meshio==${MESHIO_VERSION} 

# Meshio python deps via pip
RUN pip3 install pygmsh==${PYGMSH_VERSION} mpi4py && \
    pip3 install gmsh==${GMSH_VERSION} --user

ENV PATH=$PATH:/usr/local/bin
ENV PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.9/site-packages/gmsh-${GMSH_VERSION}-Linux64-sdk/lib/
WORKDIR /root

# Activate for jupter notebook
RUN pip3 install --upgrade --no-cache-dir jupyter jupyterlab
# EXPOSE 8888/tcp
# ENV SHELL /bin/bash

# ENTRYPOINT ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root"]