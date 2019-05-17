#!/bin/bash
git submodule update --recursive --remote --merge

export TAG="python-cuda"
docker build -t coding-python-env:$TAG .

export JUPYTER_PORT=8080
docker run --runtime=nvidia --rm -it -h python-cuda -p $JUPYTER_PORT:8080 coding-python-env:$TAG /bin/zsh
