#!/bin/bash

TAG="ubuntu-cuda"
docker build -t coding-base-env:$TAG .

docker run --runtime=nvidia --rm -it -h ubuntu-cuda coding-base-env:$TAG /bin/zsh
