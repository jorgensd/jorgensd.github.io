# This is a Dockerfile used to install dependencies for my webpage
#
# Authors:
# Jørgen S. Dokken <dokken92@gmail.com>

FROM ubuntu:22.04

WORKDIR /tmp

ARG MPI="mpich"
ARG MAKEFLAGS
ARG GMSH_VERSION="4_11_1"
ARG PYGMSH_VERSION="7.1.17"
ARG MESHIO_VERSION="5.3.4"
# Using 1.12 release of HDF5 due to https://github.com/h5py/h5py/pull/2154
ARG HDF5_SERIES="1.12"
ARG HDF5_PATCH="2"
ENV HDF5_MPI="ON"
ENV HDF5_DIR="/usr/local"

# First dependencies are general dependencies
# Second set are GMSH deps
# Third set is meshio deps
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -qq update && \
    apt-get -yq --with-new-pkgs -o Dpkg::Options::="--force-confold" upgrade && \
    apt-get -y install \
    python3-dev \
    lib${MPI}-dev \
    pkg-config \
    libxft2 \
    wget \
    cmake \
    ninja-build \
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
    libxft2 \
    libxinerama1 \
    libfltk1.3-dev \
    libfreetype6-dev  \
    libgl1-mesa-dev \
    libocct-foundation-dev \
    libocct-data-exchange-dev && \
    apt-get -y install \
    python3-lxml && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install HDF5
RUN wget -nc --quiet https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${HDF5_SERIES}/hdf5-${HDF5_SERIES}.${HDF5_PATCH}/src/hdf5-${HDF5_SERIES}.${HDF5_PATCH}.tar.gz && \
    tar xfz hdf5-${HDF5_SERIES}.${HDF5_PATCH}.tar.gz && \
    cmake -G Ninja -DCMAKE_INSTALL_PREFIX=${HDF5_DIR} -DCMAKE_BUILD_TYPE=Release -DHDF5_ENABLE_PARALLEL=on -DHDF5_ENABLE_Z_LIB_SUPPORT=on -B build-dir -S hdf5-${HDF5_SERIES}.${HDF5_PATCH} && \
    cmake --build build-dir && \
    cmake --install build-dir && \
    rm -rf /tmp/*

# Install h5py
RUN CC=mpicc python3 -m pip install -v --no-cache-dir --no-binary=h5py h5py

# Install GMSH
RUN git clone -b gmsh_${GMSH_VERSION} --single-branch --depth 1 https://gitlab.onelab.info/gmsh/gmsh.git && \
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DENABLE_BUILD_DYNAMIC=1  -DENABLE_OPENMP=1 -B build-dir -S gmsh && \
    cmake --build build-dir && \
    cmake --install build-dir && \
    rm -rf /tmp/*

# GMSH installs python library in /usr/local/lib, see: https://gitlab.onelab.info/gmsh/gmsh/-/issues/1414
ENV PYTHONPATH=/usr/local/lib:$PYTHONPATH

# Install meshio
RUN python3 -m pip install meshio


# Install PYGMSH
RUN python3 -m pip install pygmsh==${PYGMSH_VERSION}

# Install MPI4py
RUN python3 -m pip install mpi4py

ENV PATH=$PATH:/usr/local/bin
WORKDIR /root

# Install jupytext
RUN python3 -m pip install jupytext

# Activate for jupter notebook
RUN python3 -m pip install --upgrade --no-cache-dir jupyter jupyterlab
EXPOSE 8888/tcp
ENV SHELL /bin/bash

ENTRYPOINT ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root"]
