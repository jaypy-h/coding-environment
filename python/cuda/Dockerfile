FROM coding-base-env:ubuntu-cuda

ENV DEBIAN_FRONTEND noninteractive

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

USER $USER

COPY ./projects/ $HOME/projects/
RUN sudo chown -R "${USER}":"${USER}" $HOME/projects/

RUN cd $HOME/projects/test-submodule \
 && pipenv install --dev --deploy --ignore-pipfile \
 && pipenv run python -m ipykernel install --user --name=test-submodule 

EXPOSE 8080
WORKDIR $HOME 

CMD [ "zsh" ]
