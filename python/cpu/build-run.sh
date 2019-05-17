#!/bin/bash
git submodule update --recursive --remote --merge

export TAG="python-cpu"
docker build -t coding-python-env:$TAG .

export JUPYTER_PORT=8080
docker run --rm -it -h python-cpu -p $JUPYTER_PORT:8080 coding-python-env:$TAG /bin/zsh
