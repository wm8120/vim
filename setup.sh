#!/bin/bash

sudo apt install cmake

git submodule update --init

cd ./pack/plugins/start/YouCompleteMe/
./install.py --clang-completer
cd -

cd ./pack/plugins/start/fzf
./install --all
cd -
