# Simple Dockerfile to run all the scripts on a base Ubuntu image
FROM ubuntu:bionic-20180821

# Command line argument with default for MicroPython version to build
ARG VERSION=v1.0.0

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
