#!/bin/bash

for file in $(find $REPO_FULL_PATH -name "Pipfile" -type f)
do
    TARGET_PATH=$(dirname $file)
    cd $TARGET_PATH
    pipenv install --dev --deploy --ignore-pipfile --keep-outdated
    pipenv run python -m ipykernel install --user --name=env-test
done

