# Start from latest ubuntu
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

# Install miniconda
RUN apt-get update && apt -yq install wget git
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
ENV PATH="/root/miniconda3/bin:${PATH}"

# Install ase and cp2k
RUN conda install -c conda-forge ase plumed py-plumed xtb-python

# Install i-pi
RUN pip install git+https://github.com/i-pi/i-pi.git

# Copy in the example files and copy the xtb parameters into the right place 
COPY zundel-metad /root/zundel-metad
RUN cp /root/miniconda3/share/xtb/param_* /root/zundel-metad/

# by default start the i-pi/plumed server
WORKDIR /root/zundel-metad
CMD ["i-pi","input.xml"]

