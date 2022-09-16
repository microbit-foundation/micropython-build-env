# Simple Dockerfile to run all the scripts on a base Ubuntu image
FROM ubuntu:bionic-20220902

# Default value for the command line argument to select MicroPython versions
# to build. If one of these is set to "skip" it will not build it 
ARG VERSION_V1=v1.1.0-beta.1
ARG VERSION_V2=v2.1.0-beta.2

# Configure directory to save all artefacts
ARG ARTEFACTS_PATH=/home/artefacts
RUN mkdir $ARTEFACTS_PATH

# Add the scripts and requirements.txt to the docker image
COPY scripts/install_toolchain.sh \
     scripts/build_micropython_v1.sh \
     scripts/build_micropython_v2.sh \
     requirements.txt \
     /home/

WORKDIR /home/

RUN /home/install_toolchain.sh 
ENV PATH $PATH:/opt/gcc-arm-none-eabi/bin

RUN /home/build_micropython_v1.sh $VERSION_V1 $ARTEFACTS_PATH
RUN /home/build_micropython_v2.sh $VERSION_V2 $ARTEFACTS_PATH

# Collect system information into $ARTEFACTS_PATH folder
RUN echo "Python version:" > $ARTEFACTS_PATH/python_info.txt && \
    python -c "import sys;print(sys.version)" >> $ARTEFACTS_PATH/python_info.txt && \
    python -c "import struct; print('{}-bits\n'.format(struct.calcsize('P') * 8))" >> $ARTEFACTS_PATH/python_info.txt && \
    echo "Pip list:" >> $ARTEFACTS_PATH/python_info.txt && \
    python -m pip list --verbose >> $ARTEFACTS_PATH/python_info.txt && \
    apt list --installed > $ARTEFACTS_PATH/apt_packages.txt
