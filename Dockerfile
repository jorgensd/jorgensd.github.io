# This is a Dockerfile used to install dependencies for my webpage
#
# Authors:
# Jørgen S. Dokken <dokken92@gmail.com>

FROM ubuntu:24.04

WORKDIR /tmp

ARG MPI="mpich"
ARG MAKEFLAGS
ARG GMSH_VERSION="4_13_1"
ARG PYGMSH_VERSION="7.1.17"
ARG MESHIO_VERSION="5.3.5"
ENV HDF5_DIR="/usr/local"
ARG HDF5_SERIES=1.14
ARG HDF5_PATCH=3
ARG HDF5_FIX=

# First dependencies are general build deps dependencies
# Second set are GMSH deps
# Third set is meshio deps
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  \
    python3-dev \
    python3-pip \
    python3-venv \
    lib${MPI}-dev \
    pkg-config \
    libxft2 \
    wget \
    cmake \
    ninja-build && \
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
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV VIRTUAL_ENV /pygmsh-env
ENV PATH /pygmsh-env/bin:$PATH
RUN python3 -m venv ${VIRTUAL_ENV}

# Install HDF5
# Note: HDF5 CMake install has numerous bugs and inconsistencies. Test carefully.
# HDF5 overrides CMAKE_INSTALL_PREFIX by default, hence it is set
# below to ensure that HDF5 is installed into a path where it can be
# found.
RUN wget -nc --quiet https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${HDF5_SERIES}/hdf5-${HDF5_SERIES}.${HDF5_PATCH}/src/hdf5-${HDF5_SERIES}.${HDF5_PATCH}${HDF5_FIX}.tar.gz && \
    tar xfz hdf5-${HDF5_SERIES}.${HDF5_PATCH}${HDF5_FIX}.tar.gz && \
    cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DHDF5_ENABLE_PARALLEL=on -DHDF5_ENABLE_Z_LIB_SUPPORT=on -B build-dir -S hdf5-${HDF5_SERIES}.${HDF5_PATCH}${HDF5_FIX} && \
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
RUN python3 -m pip install meshio==${MESHIO_VERSION}


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
