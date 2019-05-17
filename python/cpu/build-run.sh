#!/bin/bash

export USER="ubuntu"
export PASSWORD="${USER}1234"
export HOME="/${USER}"

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
export SOURCE="git@github.com:jaypy-h/coding-environment.git"
if [ -d $TARGET ]
then 
    cd $TARGET && git pull && cd ../../
else
    git clone $SOURCE $TARGET && cd ../
fi
#==============================================

export TAG="python-cpu"
docker build -t coding-python-env:$TAG .

export JUPYTER_PORT=8080

if [ -e $SSH_KEY_PATH ]
then
    docker run --rm -it \
        -h python-cpu \
        -v $SSH_KEY_PATH:/ubuntu/.ssh/id_rsa \
        -p $JUPYTER_PORT:8080 \
        -e GIT_USER_NAEM=$GIT_USER_NAME \
        -e GIE_USER_EMAIL=$GIT_USER_EMAIL \
        -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
        -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
        -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
    coding-python-env:$TAG \
    /bin/zsh
else
    docker run --rm -it \
        -h python-cpu \
        -p $JUPYTER_PORT:8080 \
        -e GIT_USER_NAEM=$GIT_USER_NAME \
        -e GIE_USER_EMAIL=$GIT_USER_EMAIL \
        -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
        -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
        -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
    coding-python-env:$TAG \
    /bin/zsh
fi
