#!/bin/bash

#==============================================
# Docker Build=================================
#==============================================
export TAG="latest"
export DOCKER_USER="${DOCKER_USER:-ubuntu}"
export DOCKER_PASSWORD="${DOCKER_PASSWORD:-${DOCKER_USER}1234}"
export DOCKER_HOME="${DOCKER_HOME:-/${DOCKER_USER}}"

# Check projects directory
export PROJECTS="projects"
if [ -d $PROJECTS ]
then
    cd $PROJECTS
else
    mkdir $PROJECTS && cd $PROJECTS
fi

# Add repeatedly git repo =====================
export TARGET="coding-environment-test"
export SOURCE="git@github.com:jaypy-h/coding-environment-test.git"
if [ -d $TARGET ]
then 
    cd $TARGET && git pull && cd ../../
else
    git clone $SOURCE $TARGET && cd ../
fi
#==============================================

docker build \
    --build-arg USER="${DOCKER_USER}" \
    --build-arg PASSWORD="${DOCKER_PASSWORD}" \
    --build-arg HOME="${DOCKER_HOME}" \
    -t coding-python-cuda:"${TAG}" \
    .

#==============================================
# Docker Run ==================================
#==============================================
export JUPYTER_PORT=8080

if [ -e $SSH_KEY_PATH ]
then
    docker run --runtime=nvidia --rm -it \
        -h python-cuda \
        -v "${SSH_KEY_PATH}":"${DOCKER_HOME}/.ssh/id_rsa" \
        -p "${JUPYTER_PORT}":8080 \
        -e GIT_USER_NAME="${GIT_USER_NAME:-""}" \
        -e GIT_USER_EMAIL="${GIT_USER_EMAIL:-""}" \
        -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-""}" \
        -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-""}" \
        -e AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-""}" \
    coding-python-cuda:"${TAG}" \
    /bin/zsh
else
    docker run --runtime=nvidia --rm -it \
        -h python-cuda \
        -p "${JUPYTER_PORT}":8080 \
        -e GIT_USER_NAME="${GIT_USER_NAME:-""}" \
        -e GIT_USER_EMAIL="${GIT_USER_EMAIL:-""}" \
        -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-""}" \
        -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-""}" \
        -e AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-""}" \
    coding-python-cuda:$TAG \
    /bin/zsh
fi
