#!/bin/bash

export CURRENT_FULL_PATH="$(pwd)"
echo "Build Current Directory: $CURRENT_FULL_PATH"

export BASE_PROJECT_DIR="${BASE_PROJECT_DIR:-projects}"
export REPO_FULL_PATH="${CURRENT_FULL_PATH}/${BASE_PROJECT_DIR}"
export REPO_LIST="${REPO_LIST:-repo_list.txt}"

#==============================================
# Clone or Pull git repo that use
#==============================================
while IFS=';' read -ra LINE
do
    UNIT_REPO_DIR="${LINE[0]}"
    UNIT_REPO_URL="${LINE[1]}"
    UNIT_REPO_FULL_PATH="${REPO_FULL_PATH}/${UNIT_REPO_DIR}"

    if [ ! -d ${UNIT_REPO_FULL_PATH} ]; then
        git clone "${UNIT_REPO_URL}" "${BASE_PROJECT_DIR}/${UNIT_REPO_DIR}"
    else
        cd "${BASE_PROJECT_DIR}/${UNIT_REPO_DIR}"
        git pull
        cd "${CURRENT_FULL_PATH}"
    fi
done < "${REPO_LIST}"

#==============================================
# Copy Pipfile and Pipfile.lock of git repo that use
#==============================================
#export REPO_PATH="~/Projects"
#export REPO_FULL_PATH=$(eval "realpath ${REPO_PATH}")
export PIPENV_DIR="${PIPENV_DIR:-pipenv}"
export PIPENV_FULL_PATH="${CURRENT_FULL_PATH}/${PIPENV_DIR}"

cd ${REPO_FULL_PATH}
for FILE in $(find . -name "Pipfile*" -type f -exec ls {} \;)
do
    SOURCE_FILE="${REPO_FULL_PATH}/${FILE:2}"
    TARGET_FILE="${PIPENV_FULL_PATH}/${FILE:2}"
    TARGET_FULL_PATH="$(dirname ${TARGET_FILE})"
    if [ ! -d ${TARGET_FULL_PATH} ]
    then
        mkdir -p ${TARGET_FULL_PATH}
    fi
    cp -p ${SOURCE_FILE} ${TARGET_FILE}
done
cd ${CURRENT_FULL_PATH}

#==============================================
# Create Dockerfile (Select image that use)
#==============================================
if [[ ${OSTYPE} =~ "linux" ]]
then
    if [ $(lspci | grep ' VGA ' | grep 'NVIDIA' | wc -l) -gt 0 ] # ubuntu and GPU Count > 0
    then
        USE_IMAGE="FROM nvcr.io/nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04"
        RUNTIME="--runtime=nvidia"
    else
        USE_IMAGE="FROM ubuntu:18.04"
        RUNTIME=""
    fi
elif [[ ${OSTYPE} =~ "darwin" ]] # MacOS
then
    USE_IMAGE="FROM ubuntu:18.04"
    RUNTIME=""
else
    USE_IMAGE="FROM ubuntu:18.04"
    RUNTIME=""
fi

(echo ${USE_IMAGE} && cat config/Dockerfile) > Dockerfile

#==============================================
# Build Docker
#==============================================
echo "Build Docker"
export TAG="latest"
export DOCKER_USER="${DOCKER_USER:-ubuntu}"
export DOCKER_UID=$(id -u)
export DOCKER_PASSWORD="${DOCKER_PASSWORD:-${DOCKER_USER}1234}"
export DOCKER_HOME="${DOCKER_HOME:-/${DOCKER_USER}}"
export DOCKER_REPO_DIR="${DOCKER_REPO_DIR:-projects}"
export DOCKER_REPO_FULL_PATH="${DOCKER_REPO_FULL_PATH:-${DOCKER_HOME}/${DOCKER_REPO_DIR}}"

echo "#=============================================="
echo "Docker User INFO"
echo "User name: ${DOCKER_USER}, Uid: ${DOCKER_UID}, Home: ${DOCKER_HOME}, Password: ${DOCKER_PASSWORD}"
echo "#=============================================="

docker build \
    --build-arg USER="${DOCKER_USER}" \
    --build-arg UID="${DOCKER_UID}" \
    --build-arg PASSWORD="${DOCKER_PASSWORD}" \
    --build-arg HOME="${DOCKER_HOME}" \
    --build-arg PIPENV_DIR="${PIPENV_DIR}" \
    --build-arg REPO_FULL_PATH="${DOCKER_REPO_FULL_PATH}" \
    -t coding-python-cpu:"${TAG}" \
    .

#==============================================
# Delete Temp Files
#==============================================
rm Dockerfile
rm -fr ${PIPENV_DIR}

#==============================================
# Run Docker
#==============================================
export JUPYTER_PORT="${JUPYTER_PORT:-8080}"
export MARKDOWN_PORT="${MARKDOWN_PORT:-1337}"

if [ -e ${SSH_KEY_PATH} ]
then
    docker run ${RUNTIME} --rm -it \
        -h python-cpu \
        -p "${JUPYTER_PORT}":8080 \
        -p "${MARKDOWN_PORT}":1337 \
        -v "${SSH_KEY_PATH}":"${DOCKER_HOME}/.ssh/id_rsa" \
        -v "${REPO_FULL_PATH}":"${DOCKER_REPO_FULL_PATH}" \
        -e GIT_USER_NAME="${GIT_USER_NAME:-""}" \
        -e GIT_USER_EMAIL="${GIT_USER_EMAIL:-""}" \
        -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-""}" \
        -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-""}" \
        -e AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-""}" \
    coding-python-cpu:"${TAG}" \
    /bin/zsh
else
    docker run ${RUNTIME} --rm -it \
        -h python-cpu \
        -p "${JUPYTER_PORT}":8080 \
        -p "${MARKDOWN_PORT}":1337 \
        -e GIT_USER_NAME="${GIT_USER_NAME:-""}" \
        -e GIT_USER_EMAIL="${GIT_USER_EMAIL:-""}" \
        -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-""}" \
        -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-""}" \
        -e AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-""}" \
    coding-python-cpu:$TAG \
    /bin/zsh
fi
