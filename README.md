# MicroPython Replicable Build Environment

Replicable build environment for MicroPython

## Instructions

### Build docker image

Build the docker image, the `VERSION` should be a git tag:

```
docker build -t "ubit-upy-img" --build-arg VERSION=v1.0.0 .
```

To keep good traceability it's better to save the build output, so preferably do:

```
docker build -t "ubit-upy-img" --build-arg VERSION=v1.0.0 . 2>&1 | tee shared/docker_build_op.txt
```

### Volumes

This section is a WIP, we need to figure out how this works...

To find the artefacts, first find the created volume:

```
docker run -it microbit-micropython
docker volume ls
```

### Copy files from docker to host

```
docker run -it --name ubit-upy-container microbit-micropython
docker cp microbit-micropython:/home/artefacts .
```


### Save docker image

```
docker save ubit-upy-img > ubit-upy-img.tar
gzip -c ubit-upy-img.tar > ubit-upy-img.tar.gz
```


## Tips

Run a bash session (launches a new container) inside an existing docker image:

```
docker run -it --entrypoint /bin/bash microbit-micropython
```
