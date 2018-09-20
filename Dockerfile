# Simple Dockerfile to just run all the scripts on a base Ubuntu image
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

RUN mkdir /home/artefacts
# Contents inside a volume are removed, we need to figure out how to use this
# VOLUME ["/home/artefacts"]

# Execute the scripts
WORKDIR /home/
RUN chmod +x /home/run_all.sh
RUN /home/run_all.sh $VERSION /home/artefacts
