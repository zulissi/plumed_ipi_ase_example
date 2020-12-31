# Start from latest ubuntu
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

# this is home for root user
WORKDIR /root

# install libraries and plumed
#RUN buildDeps="git" \
# && runtimeDeps="gawk libopenblas-base libgomp1 make openssh-client openmpi-bin vim zlib1g git g++ libopenblas-dev libopenmpi-dev xxd zlib1g-dev ca-certificates" \
# && apt-get -yq update \
# && apt-get -yq upgrade \
# && apt -yq install $buildDeps $runtimeDeps --no-install-recommends 

#RUN git clone http://github.com/plumed/plumed2.git \
# && cd plumed2 \
# && ./configure --enable-modules=all CXXFLAGS=-O3 \
# && make -j 4

#RUN cd plumed2 && make install

# Install miniconda
RUN apt-get update && apt -yq install wget git build-essential
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
ENV PATH="/root/miniconda3/bin:${PATH}"

# Install ase and cp2k
RUN conda install -c conda-forge cp2k ase plumed py-plumed
ENV ASE_CP2K_COMMAND=/root/miniconda3/bin/cp2k_shell.ssmp

# Install i-pi
RUN pip install git+https://github.com/i-pi/i-pi.git

# by default enter bash in the zundel example directory
COPY zundel-metad /root/zundel-metad
WORKDIR /root/zundel-metad
CMD ["i-pi","input.xml"]

