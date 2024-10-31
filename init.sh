#!/bin/bash

# remove previous attempts
docker stop ubuntu-dev;
docker rm ubuntu-dev;
docker image rm ubuntu-dev
rm -rf mnt;

podman build -t ubuntu-dev .;

podman run --name ubuntu-dev -p 8080:80 -v "$PWD/mnt:/mnt" -dt ubuntu-dev;

podman exec -it ubuntu-dev /bin/zsh;

