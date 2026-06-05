#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Nothing specified, nothing added."
    exit 1
fi

git-core write-index "$@"