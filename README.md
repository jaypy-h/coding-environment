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
    * `$SSH_KEY_PATH` **caution: pull path**

## Images
* `coding-python-cpu:latest`  : Setting zsh, vim, tmux and python(CPU Ver.)
    * `./python/cpu/build-run.sh`
* `coding-python-cuda:latest` : Setting zsh, vim, tmux and python(CUDA Ver.)
    * `./python/cuda/build-run.sh`

## Caution
Modify `Dockerfile` and `buil-run.sh` when including git repo in image.
* `./python/cpu/Dockerfile`
* `./python/cpu/build-run.sh`

**OR**

* `./python/cuda/Dockerfile`
* `./python/cuda/build-run.sh`

# Vim

## Leader Key
`<leader>: ,`

## Split Layouts
* `:sp <filename>` # vertical split
* `:vs <filename>` # horizontal split
* Key combos
    * `[CTRL] + J` # move to the split below
    * `[CTRL] + K` # move to the split above
    * `[CTRL] + L` # move to the split to the right
    * `[CTRL] + H` # move to the split to the left

## Buffers
* `:ls` # list all buffers
* `:b <buffer number>` # switch to an open buffer

## Code Folding
#### [SimpylFold](https://github.com/tmhedberg/SimpylFold)
* `<space>`

## Python Indentation
### Auto-Indentation
#### [indentpython.vim](https://github.com/vim-scripts/indentpython.vim)

## Auto-Complete
#### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
* `<leader> + g` # GoTo
* `<leader> + d` # GoToDeclaration
* `<leader> + t` # GetType
* `<leader> + p` # GetParent
* `[CTRL] + O` # jump before postion
* `[CTRL] + I` # jump after postion

## Syntax Checking/Highlighting
#### [syntastic](https://github.com/vim-syntastic/syntastic) *# Check Syntax*
#### [vim-flake8](https://github.com/nvie/vim-flake8) *# Check PEP8*

## Color Schemes
#### [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
#### [Zenburn](https://github.com/jnurmine/Zenburn)
#### [molokai](https://github.com/tomasr/molokai)
#### [jellybeans.vim](https://github.com/nanotech/jellybeans.vim)
* `[F5]` # change between dark and light theme

## File Browsing
#### [NERDTree](https://github.com/scrooloose/nerdtree)
#### [vim-nerdtree-tabs](https://github.com/jistr/vim-nerdtree-tabs)
* `<leader> + nt`  # NERDTree
* `<leader> + ntt` # NERDTreeToggle

## Python
* `[F2]` # Execute Source with python

## Ctrlp
#### [ctrlp](https://github.com/kien/ctrlp.vim)
* `[CTRL] + P` or `<leader> + p` # enable search
* `<leader> + bb` # CtrlPBuffer
* `<leader> + bm` # CtrlPMixed
* `<leader> + bs` # CtrlPMRU

## Buffergator
#### [Buffergator](https://github.com/jeetsukumaran/vim-buffergator)
* `<leader> + h`  : go previous buffer
* `<leader> + l`  : gonext buffer
* `<leader> + bl` : show all buffer list
* `<leader> + T`  : create new buffer
* `<leader> + bq` : close buffer

## Livemark
#### [Livedown](https://github.com/shime/vim-livedown)
* `<leader> + mds` : launch the Livedown server and preview your markdown file
* `<leader> + mdk` : stop the Livedown server
* `<leader> + mdt` : launch/kill the Livedown server

## Reference
* [VIM and Python – A Match Made in Heaven](https://realpython.com/vim-and-python-a-match-made-in-heaven/#virtualenv-support)
* [Vim Tab Madness. Buffers vs Tabs](https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)
