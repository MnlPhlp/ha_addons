#! /bin/bash

# needed this to fix issues with building arm64 image on amd64 machine

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --name multiarch --driver docker-container --use
docker buildx inspect --bootstrap
