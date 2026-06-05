#!/bin/bash
# git-commit.sh

message=""
while [ $# -gt 0 ]; do
    case "$1" in
        -m|--message)
            message="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

if [ -z "$message" ]; then
    echo "Aborting commit due to empty commit message."
    exit 1
fi

tree=$(git-core write-tree)
if [ -z "$tree" ]; then
    echo "Nothing to commit"
    exit 1
fi

parent=$(git-core symbolic-ref HEAD 2>/dev/null || git-core read-ref HEAD)
if [ -n "$parent" ]; then
    commit=$(git-core commit-tree "$tree" -p "$parent" -m "$message")
else
    commit=$(git-core commit-tree "$tree" -m "$message")
fi

branch=$(git-core read-ref HEAD)
if [ -z "$branch" ] || [ "${branch:0:5}" = "ref: " ]; then
    branch="refs/heads/master"
fi

git-core update-ref "$branch" "$commit"
if [ "$branch" = "refs/heads/master" ]; then
    git-core symbolic-ref HEAD refs/heads/master
fi

echo "[$branch $(echo $commit | cut -c1-7)] $message"