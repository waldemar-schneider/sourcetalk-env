#!/bin/bash
git config --global user.name "$1"
git config --global user.email "$2"
git config --global credential.helper 'cache --timeout=100000'

rm -Rf sourcetalk-env
git clone https://github.com/$1/sourcetalk-env.git
cd sourcetalk-env
echo TEST... >> README.md
git add .
git commit -m "TEST..."
git push
echo OK >> README.md
git add .
git commit -m "TEST..."
git push
cd ..
