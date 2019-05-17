#!/bin/bash

TAG="ubuntu-cpu"
docker build \
    --build-arg USER="${USER}" \
    --build-arg PASSWORD="${PASSWORD:-${USER}1234}" \
    --build-arg HOME="${HOME:-/${USER}}" \
    -t coding-base-env:latest \
    -t coding-base-env:$TAG \
    .

docker run --rm -it -h ubuntu-cpu coding-base-env:$TAG /bin/zsh
