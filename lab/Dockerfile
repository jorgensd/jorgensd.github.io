FROM pygmsh-env as pygmsh-lab
LABEL description="GMSH and PYGMSH with ubuntu 20.04 in Jupyter Lab"

RUN mkdir -p shared

RUN pip3 install --upgrade --no-cache-dir jupyter jupyterlab
EXPOSE 8888/tcp
ENV SHELL /bin/bash

ENTRYPOINT ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root"]