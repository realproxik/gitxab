#!/bin/bash

if [ -d .git ]; then
    echo "Reinitialized existing Git repository in $(pwd)/.git/"
    exit 0
fi

git-core init-db