# Simple Dockerfile to run all the scripts on a base Ubuntu image
FROM ubuntu:bionic-20180821

# Command line argument for MicroPython version to build with a default value
ARG VERSION=v1.0.1

# Add the scripts and Pipfiles to the docker image
COPY scripts/install_toolchain.sh \
     scripts/build_micropython.sh \
     scripts/collect.sh \
     scripts/run_all.sh \
     Pipfile \
     Pipfile.lock \
     /home/

# Execute the scripts
WORKDIR /home/
RUN mkdir /home/artefacts
RUN chmod +x /home/run_all.sh
RUN /home/run_all.sh $VERSION /home/artefacts
