# coding-environment
Coding environment with docker

## Variables
  * git
    * `$GIT_USER_NAME`
    * `$GIT_USER_EMAIL`
  * aws
    * `$AWS_ACCESS_KEY_ID`
    * `$AWS_SECRET_ACCESS_KEY`
    * `$AWS_DEFAULT_REGION`
  * ssh
    * `$SSH_KEY_PATH`

## Images
* `coding-python-cpu:latest`  : Setting pipenv and git repo (CPU Ver.)
  * `./python/cpu/build-run.sh`
* `coding-python-cuda:latest` : Setting pipenv and git repo (CUDA Ver.)
  * `./python/cuda/build-run.sh`

## Caution
Modify `Dockerfile` and `buil-run.sh` when including git repo in image.
  * `./python/cpu/Dockerfile`
  * `./python/cpu/build-run.sh`

**OR**

  * `./python/cuda/Dockerfile`
  * `./python/cuda/build-run.sh`

