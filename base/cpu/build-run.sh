#!/bin/bash

TAG="ubuntu-cpu"
docker build -t coding-base-env:$TAG .

docker run --rm -it -h ubuntu-cpu coding-base-env:$TAG /bin/zsh
