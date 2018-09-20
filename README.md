# MicroPython Replicable Build Environment

Replicable build environment for MicroPython

## Instructions

### Build docker image

Build the docker image, the `VERSION` should be a git tag:

```
docker build -t "microbit-micropython" --build-arg VERSION=v1.0.0 .
```

To keep good traceability it's better to save the build output, so preferably do:

```
docker build -t "microbit-micropython" --build-arg VERSION=v1.0.0 . 2>&1 | tee shared/docker_build_op.txt
```


### Volumes

This section is a WIP, we need to figure out how this works...

To find the artefacts, first find the created volume:

```
docker run -it microbit-micropython
docker volume ls
```

Then see where it is mounted

```

```

## Tips

Run a bash session (launches a new container) inside an existing docker image:

```
docker run -it --entrypoint /bin/bash microbit-micropython
```
