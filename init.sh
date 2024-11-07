#!/bin/bash

# determine the container runtime to use, prioritize 'docker', fall back to 'podman' if 'docker' is unavailable
if command -v docker &>/dev/null; then
  container_runtime="docker"
elif command -v podman &>/dev/null; then
  container_runtime="podman"
else
  echo "error: neither Docker nor Podman is installed ... exiting"
  exit 1
fi

# clean up any previous attempts by stopping and removing the container, deleting the image, and clearing the mount directory
$container_runtime stop ubuntu-dev &>/dev/null
$container_runtime rm ubuntu-dev &>/dev/null
$container_runtime image rm ubuntu-dev &>/dev/null

# create a 'mnt' directory if it does not already exist
mkdir -p mnt

# build a new Docker image tagged as 'ubuntu-dev' from the local Dockerfile
if ! $container_runtime build -t ubuntu-dev . -f src/Dockerfile; then
  echo "error: image build failed ... exiting"
  exit 1
fi

# start a new container named 'ubuntu-dev', exposing port 8080 to port 80 in the container
# mount the 'mnt' directory from the current working directory to '/mnt' in the container
if ! $container_runtime run --name ubuntu-dev -p 8080:80 -v "$PWD/mnt:/mnt" -dt ubuntu-dev; then
  echo "error: container run failed ... exiting"
  exit 1
fi

# enter an interactive shell session in the running 'ubuntu-dev' container
$container_runtime exec -it ubuntu-dev /bin/zsh

