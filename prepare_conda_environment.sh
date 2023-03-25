#!/usr/bin/env bash
ENV_NAME=$(cat environment.yml | grep -e "name: \w\+" | awk '{print $2}')
AVAILABLE_ENVS=($(conda info --envs | grep /envs/ | awk '{print $1}'))

# if ENV_NAME in $AVAILABLE_ENVS
if [[ ! " ${AVAILABLE_ENVS[*]} " =~ " ${ENV_NAME} " ]]; then
    conda env create -f environment.yml $@
    echo "conda activate $ENV_NAME" > .autoenv.zsh
    echo "conda deactivate" > .autoenv_leave.zsh
    echo ".autoenv.zsh" >> .git/info/exclude
    echo ".autoenv_leave.zsh" >> .git/info/exclude
    #conda activate $ENV_NAME
fi
