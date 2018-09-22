# MicroPython Replicable Build Environment

Replicable build environment for MicroPython

## Instructions

### Build docker image

Build the docker image, the `VERSION` should be a MicroPython git tag:

```
docker build -t "ubit-upy-img" --build-arg VERSION=v1.0.0 .
```

For better traceability it's good to save the build output, so preferably do:

```
docker build -t "ubit-upy-img" --build-arg VERSION=v1.0.0 . 2>&1 | tee docker_build_op.txt
```

### Copy files from docker to host

```
docker run --name ubit-upy-container ubit-upy-img
docker cp ubit-upy-container:/home/artefacts .
```


### Save docker image

```
docker save ubit-upy-img > ubit-upy-img.tar
gzip -c ubit-upy-img.tar > ubit-upy-img.tar.gz
```

### Load docker image

```
gzip -d ubit-upy-img.tar.gz
docker load < ubit-upy-img.tar
docker image ls -a
```

## Tips

Run a bash session (launches a new container) inside an existing docker image:

```
docker run -it --entrypoint /bin/bash ubit-upy-img
```
