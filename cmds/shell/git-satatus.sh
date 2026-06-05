#!/bin/bash
# git-status.sh

if [ ! -d .git ]; then
    echo "Not a git repository"
    exit 1
fi

branch=$(git-core read-ref HEAD 2>/dev/null || echo "")
if [ "${branch:0:5}" = "ref: " ]; then
    branch=${branch:5}
    branch=${branch#refs/heads/}
else
    branch="HEAD (no branch)"
fi

echo "On branch $branch"

# Check for staged changes
index=$(git-core read-index 2>/dev/null)
if [ -n "$index" ]; then
    echo "Changes to be committed:"
    echo "$index" | while read mode sha1 path; do
        if [ -f "$path" ]; then
            current=$(git-core hash-object "$path")
            if [ "$current" != "$sha1" ]; then
                echo "        modified: $path"
            else
                echo "        new file: $path"
            fi
        fi
    done
fi

# Check for unstaged changes
echo "Changes not staged for commit:"
find . -type f -not -path './.git/*' | while read f; do
    path=${f#./}
    if ! echo "$index" | grep -q "$path$"; then
        echo "        untracked: $path"
    fi
done