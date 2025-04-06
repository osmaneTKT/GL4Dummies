FROM ubuntu:20.04

ENV TZ=Europe/Paris

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    pkg-config \
    autotools-dev \
    autoconf \
    automake \
    libtool \
    cmake \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y mesa-utils

RUN git clone https://github.com/noalien/GL4Dummies.git /opt/GL4Dummies \
    && cd /opt/GL4Dummies \
    && make -f Makefile.autotools \
    && ./configure \
    && make \
    && make install

ENV XDG_RUNTIME_DIR=/tmp/runtime
RUN mkdir -p /tmp/runtime

ENV PATH="/usr/local/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/lib"


WORKDIR /workspace


CMD ["/bin/bash"]