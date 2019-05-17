# coding-environment
Coding environment with docker

## Images
* `coding-base-env:ubuntu-cpu`    : Setting vim, ZSH, Oh My ZSH (CPU Ver.)
  * `./base/cpu/build-run.sh`
* `coding-base-env:ubuntu-cuda`   : Setting vim, ZSH, Oh My ZSH (CPU Ver.)
  * `./base/cuda/build-run.sh`
* `coding-python-env:python-cpu`  : Setting pipenv and git repo (CPU Ver.)
  * `./python/cpu/build-run.sh`
* `coding-python-env:python-cuda` : Setting pipenv and git repo (CUDA Ver.)
  * `./python/cuda/build-run.sh`

## Caution
Modify `Dockerfile` and `buil-run.sh` when including git repo in image `coding-python-env`.
  * `./python/cpu/Dockerfile`
  * `./python/cpu/build-run.sh`
**or**
  * `./python/cuda/Dockerfile`
  * `./python/cuda/build-run.sh`
