FROM continuumio/miniconda3:22.11.1
MAINTAINER Alexander Paul <alex.paul@wustl.edu>

LABEL \
  version="1.0.0" \
  description="Image for DeepMosaic(https://github.com/Virginiaxu/DeepMosaic)"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    gcc \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

COPY reqs.txt /tmp/
RUN conda config --add channels bioconda \
    && conda config --add channels conda-forge \
    && conda env create -n deepmosaic -f /tmp/reqs.txt \
    && pip install tables efficientnet_pytorch

WORKDIR /opt

# below new
RUN wget https://github.com/git-lfs/git-lfs/releases/download/v3.3.0/git-lfs-linux-amd64-v3.3.0.tar.gz \
    && tar -zxf git-lfs-linux-amd64-v3.3.0.tar.gz \
    && rm git-lfs-linux-amd64-v3.3.0.tar.gz \
    && cd git-lfs-3.3.0 \
    && ./install.sh \
    && cd .. \
    && git clone --recursive https://github.com/Virginiaxu/DeepMosaic \
    && rm -rf git-lfs-4.3.-1


