#!/bin/bash

git submodule update --init

cd ./pack/plugins/start/YouCompleteMe/
./install.py --clang-completer
cd -

cd ./pack/plugins/start/fzf
./install --all
cd -
