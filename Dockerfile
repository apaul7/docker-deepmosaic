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

WORKDIR /opt
RUN wget https://github.com/git-lfs/git-lfs/releases/download/v3.3.0/git-lfs-linux-amd64-v3.3.0.tar.gz \
    && tar -zxf git-lfs-linux-amd64-v3.3.0.tar.gz \
    && rm git-lfs-linux-amd64-v3.3.0.tar.gz \
    && cd git-lfs-3.3.0 \
    && ./install.sh \
    && cd .. \
    && rm -rf git-lfs-4.3.-1

ENV DEEPMOSAIC_VERSION=v1.1.0
RUN git clone --recursive --branch ${DEEPMOSAIC_VERSION} https://github.com/Virginiaxu/DeepMosaic

RUN conda update -n base -c defaults conda
RUN conda create -n DeepMosaic python=3.7
RUN conda install -n DeepMosaic pandas pip
RUN conda install -n DeepMosaic matplotlib
RUN conda install -n DeepMosaic pytorch
RUN conda install -n DeepMosaic pip
RUN /opt/conda/envs/DeepMosaic/bin/python -m pip install pysam tables efficientnet_pytorch scipy

