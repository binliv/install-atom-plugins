#!/usr/bin/env bash

ATOM_PACKAGE_PATH=${HOME}/.atom/packages
declare -A gitUrls

gitUrls=(["atom-beautify"]="https://github.com/Glavin001/atom-beautify.git"
	["emmet-atom"]="https://github.com/emmetio/emmet-atom.git"
)
cd $ATOM_PACKAGE_PATH
for k in "${!gitUrls[@]}"
do
  #echo "${k} -> ${gitUrls[${k}]}"
  git clone --depth=1 ${gitUrls[${k}]} 
  cd ${k}
  npm install --verbose
  cd -
done
