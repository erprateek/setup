#!/bin/bash

echo "Running Homebrew upgrades ... "
brew --version
brew update && brew upgrade

echo "Cleaning up brew caches/temp files ... "
brew cleanup

echo "Running pip upgrades ... "
pip install --no-cache-dir --upgrade pip
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install --no-cache-dir -U


echo "Running conda upgrades ... "
conda update conda
conda update anaconda
conda update --all
conda clean --all

echo "Done!"
