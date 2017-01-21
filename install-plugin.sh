#!/usr/bin/env bash

ATOM_PACKAGE_PATH=/c/Users/Administrator/.atom/packages
declare -A gitUrls

gitUrls=(["atom-beautify"]=https://github.com/Glavin001/atom-beautify.git)
cd $ATOM_PACKAGE_PATH
for k in "${!gitUrls[@]}"
do
  #echo "${k} -> ${gitUrls[${k}]}"
  git clone --depth=1 https://github.com/Glavin001/atom-beautify.git
  cd ${k}
  npm install
done