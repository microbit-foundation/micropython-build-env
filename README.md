# MicroPython Replicable Build Environment

Replicable build environment for MicroPython

## Instructions

### Build docker image

Build the docker image, you can overwrite the default versions by setting the
 `VERSION_V1` and `VERSION_V2` arguments with a MicroPython git tag:

```
docker build -t "ubit-upy-img" --build-arg VERSION_V1=v1.0.0 --build-arg VERSION_V2=v2.0.0 .
```

Either of the builds can be skipped by passing the "skip" string to the
version build argument, e.g. `--build-arg VERSION_V1=skip`

For better traceability it's recommendable to save the build output, so preferably do:

```
docker build -t "ubit-upy-img" --build-arg VERSION_V1=v1.0.0 --build-arg VERSION_V2=v2.0.0 . 2>&1 | tee docker_build_op.txt
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

To run a bash session in a new container from an existing Docker image:

```
docker run -it --entrypoint /bin/bash ubit-upy-img
```

## License

The contents of this repository are released under the [MIT LICENse](LICENSE).

SPDX-License-Identifier: MIT

## Code of Conduct

Trust, partnership, simplicity and passion are our core values we live and
breathe in our daily work life and within our projects.
Our open-source projects are no exception.
We have an active community which spans the globe and we welcome and encourage
participation and contributions to our projects by everyone.
We work to foster a positive, open, inclusive and supportive environment and
trust that our community respects the micro:bit code of conduct.
Please see our [code of conduct](https://microbit.org/safeguarding/)
which outlines our expectations for all those that participate in ou
community and details on how to report any concerns and what would happen
should breaches occur.
