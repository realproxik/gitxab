#!/bin/bash
# git-branch.sh

if [ $# -eq 0 ]; then
    current=$(git-core read-ref HEAD 2>/dev/null || echo "")
    if [ "${current:0:5}" = "ref: " ]; then
        current=${current:5}
    fi
    
    for ref in .git/refs/heads/*; do
        if [ -f "$ref" ]; then
            name=$(basename "$ref")
            if [ "refs/heads/$name" = "$current" ]; then
                echo "* $name"
            else
                echo "  $name"
            fi
        fi
    done
else
    branch="$1"
    commit=$(git-core read-ref HEAD)
    if [ "${commit:0:5}" = "ref: " ]; then
        commit=$(git-core read-ref "${commit:5}")
    fi
    git-core update-ref "refs/heads/$branch" "$commit"
    echo "Created branch $branch"
fi
