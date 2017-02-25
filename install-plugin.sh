#!/usr/bin/env bash

ATOM_PACKAGE_PATH=${HOME}/.atom/packages
declare -A PLUGIN_URLS


PLUGIN_URLS=(["atom-beautify"]="https://github.com/Glavin001/atom-beautify.git"
	["emmet-atom"]="https://github.com/emmetio/emmet-atom.git"
  ["minimap"]="https://github.com/atom-minimap/minimap"
)

function check_pull_needed()
{
    local UPSTREAM=${1:-'@{u}'}
    local LOCAL=$(git rev-parse @)
    local REMOTE=$(git rev-parse "$UPSTREAM")
    local BASE=$(git merge-base @ "$UPSTREAM")

    if [ $LOCAL = $REMOTE ]; then
        echo "Up-to-date"
    elif [ $LOCAL = $BASE ]; then
        echo "Need to pull"
    elif [ $REMOTE = $BASE ]; then
        echo "Need to push"
    else
        echo "Diverged"
    fi
}
cd $ATOM_PACKAGE_PATH
for k in "${!PLUGIN_URLS[@]}"
do
  if [[ -d ${ATOM_PACKAGE_PATH}/${k} ]]; then
    cd ${k}
    if [[ $(check_pull_needed) != 'Up-to-date' ]]; then
        echo "upgrade "${k};
        git pull
        yarn install
    else
        echo ${k}" uptodate."
    fi
    cd - > /dev/null
  else
    echo "install "${k};  
    git clone --depth=1 ${PLUGIN_URLS[${k}]} 
    cd ${k}
    yarn install --verbose
    cd - > /dev/null
  fi
  #echo "${k} -> ${PLUGIN_URLS[${k}]}"

done
