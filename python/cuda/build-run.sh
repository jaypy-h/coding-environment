#!/bin/bash

export PROJECTS="projects"
if [ -d $PROJECTS ]
then
    cd $PROJECTS
else
    mkdir $PROJECTS && cd $PROJECTS
fi

# Add repeatedly git repo =====================

export TARGET="coding-environment-test"
export SOURCE="https://github.com/jaypy-h/coding-environment-test.git"
if [ -d $TARGET ]
then 
    cd $TARGET && git pull && cd ../../
else
    git clone $SOURCE $TARGET && cd ../../
fi

#==============================================

export TAG="python-cuda"
docker build -t coding-python-env:$TAG .

export JUPYTER_PORT=8080
docker run --runtime=nvidia --rm -it -h python-cuda -p $JUPYTER_PORT:8080 coding-python-env:$TAG /bin/zsh
