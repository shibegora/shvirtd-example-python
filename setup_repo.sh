#! /bin/bash

REPO_PATH=/opt/shvirtd-example-python

# get repo
git clone https://github.com/shibegora/shvirtd-example-python.git $REPO_PATH

# run project
cd $REPO_PATH
docker compose up -d
cd