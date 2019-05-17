FROM coding-base-env:ubuntu-cpu

ENV DEBIAN_FRONTEND noninteractive

#ENV SSH_KEY
ENV GIT_USER_NAME
ENV GIT_USER_EMAIL

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

USER $USER

#COPY $SSH_KEY $HOME/.ssh/ssh_key
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
