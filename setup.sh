#!/bin/bash

sudo apt install cmake silversearcher-ag clang-format

git submodule update --init --recursive

cd ./pack/plugins/start/YouCompleteMe/
./install.py --clang-completer
cd -

cd ./pack/plugins/start/fzf
./install --all
cd -
