FROM nvcr.io/nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive

ARG USER
ARG PASSWORD
ARG HOME

ENV USER ${USER:-"ubuntu"}
ENV PASSWORD ${PASSWORD:-"${USER}1234"}
ENV HOME ${HOME:-"/${USER}"}
ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""
ENV AWS_DEFAULT_REGION ""
ENV ZSH_THEME ${ZSH_THEME:-"powerlevel9k\/powerlevel9k"}
ENV VIM_COLOR_SCHEME ${VIM_COLOR_SCHEME:-"solarized"}
ENV TERM xterm-256color
ENV EDITOR vim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    apt-utils \
 && apt-get -y install \
    sudo \
    python3-dev \
    vim \
    curl \
    git \
    wget \
    build-essential \
    cmake \
    clang \
    language-pack-en \
    zsh \
    powerline \
    fonts-powerline \
    zsh-theme-powerlevel9k \
    zsh-syntax-highlighting \
    autojump \
    tmux \
    imagemagick \
    unzip \
 && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
 && update-alternatives --config python \
 && curl -sk https://bootstrap.pypa.io/get-pip.py | python \
 && pip install --upgrade pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN pip install jupyter

# add a user (--disabled-password: the user won't be able to use the account until the password is set)
RUN adduser --quiet --disabled-password --shell /bin/zsh --home $HOME --gecos "User" $USER \
 && echo "${USER}:${PASSWORD}" | chpasswd \
 && usermod -aG sudo $USER \
 && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ADD .vimrc $HOME/.vimrc
RUN chown -R $USER:$USER $HOME
USER $USER

RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim \
 && vim +PluginInstall +qall \
 && cd $HOME/.vim/bundle/YouCompleteMe \
 && git submodule update --init --recursive \
 && ./install.py --clang-completer

RUN sed -i "s/\"colorscheme colorscheme/colorscheme ${VIM_COLOR_SCHEME}/" $HOME/.vimrc \
 && if [ "$VIM_COLOR_SCHEME" = "solarized"  ]; then \
      sed -i "s/\"set background=dark/set background=dark/" $HOME/.vimrc && \
      sed -i "s/\"call togglebg#map(\"<F5>\")/call togglebg#map(\"<F5>\")/" $HOME/.vimrc; \
    fi
# https://gist.github.com/MichalZalecki/4a87880bbe7a3a5428b5aebebaa5cd97i "

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
 && git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
 && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
 && git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k \
 && sed -i "s/ZSH_THEME="'"'"robbyrussell"'"'"/ZSH_THEME="'"'"${ZSH_THEME}"'"'"/" $HOME/.zshrc \
 && sed -i 's/plugins=(git)/plugins=(git sudo autojump zsh-autosuggestions zsh-syntax-highlighting ssh-agent)\nzstyle :omz:plugins:ssh-agent agent-forwarding on/' $HOME/.zshrc \
 && echo "export SSH_KEY_PATH=\"~/.ssh/rsa_id\"" >> $HOME/.zshrc \
 && echo "export TERM=\"${TERM}\"" >> $HOME/.zshrc \
 && echo "export EDITOR=\"${EDITOR}\"" >> $HOME/.zshrc \
 && echo "export POWERLEVEL9K_PYTHON_ICON='\U1F40D'" >> $HOME/.zshrc \
 && echo "bindkey -v" >> $HOME/.zshrc \
 && echo "export KEYTIMEOUT=1" >> $HOME/.zshrc \
 && echo "POWERLEVEL9K_MODE='nerdfont-complete'" >> $HOME/.zshrc \
 && echo "POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode virtualenv context dir vcs)" >> $HOME/.zshrc \
 && echo "POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history)" >> $HOME/.zshrc \
 && echo "POWERLEVEL9K_PROMPT_ON_NEWLINE=true" >> $HOME/.zshrc \
 && export JUPYTER_PASSWORD=$(python -c "from notebook.auth import passwd; print(passwd('${PASSWORD}'))") \
 && jupyter notebook --generate-config \
 && echo "c = get_config()" >> $HOME/.jupyter/jupyter_notebook_config.py \
 && echo "c.NotebookApp.allow_origin = '*'" >> $HOME/.jupyter/jupyter_notebook_config.py \
 && echo "c.NotebookApp.ip = '0.0.0.0'" >> $HOME/.jupyter/jupyter_notebook_config.py \
 && echo "c.NotebookApp.notebook_dir = '$HOME'" >> $HOME/.jupyter/jupyter_notebook_config.py \
 && echo "c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py \
 && echo "c.NotebookApp.password = '${JUPYTER_PASSWORD}'" >> $HOME/.jupyter/jupyter_notebook_config.py \
 && echo "c.NotebookApp.port = 8080" >> $HOME/.jupyter/jupyter_notebook_config.py

ENV PATH="$HOME/.local/bin:$PATH"
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT:$PYENV_ROOT/bin:$PATH"

# Setting Pyenv
RUN git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv \
 && git clone https://github.com/yyuu/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv \
 && echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.zshenv \
 && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshenv \
 && echo 'export PATH="$PYENV_ROOT:$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshenv \
 && echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.zshenv \
 && echo 'eval "$(pyenv init -)"' >> $HOME/.zshenv 

RUN pip install pipenv --user \
 && pip install awscli --user 

ENV GIT_USER_NAME ""
ENV GIT_USER_EMAIL ""

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

COPY ./projects/ $HOME/projects/

RUN mkdir -p $HOME/.ssh \
 && sudo chown -R "${USER}":"${USER}" $HOME/projects/

# Add repeatedly git repo =====================
RUN cd $HOME/projects/coding-environment-test \
 && pipenv install --dev --deploy --ignore-pipfile \
 && pipenv run python -m ipykernel install --user --name=env-test
#==============================================

RUN git config --global user.name "\"${GIT_USER_NAME}\"" \
 && git config --global user.email "${GIT_USER_EMAIL}"

EXPOSE 8080

WORKDIR $HOME 

CMD [ "zsh" ]
