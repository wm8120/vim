#!/bin/bash

sudo apt install cmake
sudo apt install clang-format

git submodule update --init

cd ./pack/plugins/start/YouCompleteMe/
./install.py --clang-completer
cd -

cd ./pack/plugins/start/fzf
./install --all
cd -
