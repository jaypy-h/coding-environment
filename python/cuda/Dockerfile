FROM coding-base-env:ubuntu-cuda

ENV DEBIAN_FRONTEND noninteractive

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

USER $USER

COPY ./projects/ $HOME/projects/
RUN sudo chown -R "${USER}":"${USER}" $HOME/projects/

# Add repeatedly git repo =====================
RUN cd $HOME/projects/coding-environment-test \
 && pipenv install --dev --deploy --ignore-pipfile \
 && pipenv run python -m ipykernel install --user --name=env-test
#==============================================

EXPOSE 8080
WORKDIR $HOME 

CMD [ "zsh" ]
