#!/bin/bash
# git-checkout.sh

if [ $# -lt 1 ]; then
    echo "You must specify a branch or commit."
    exit 1
fi

target="$1"
sha1=$(git-core read-ref "refs/heads/$target" 2>/dev/null || echo "$target")

if [ -z "$sha1" ]; then
    echo "error: pathspec '$target' did not match any known ref"
    exit 1
fi

tree=$(git-core cat-file -p "$sha1" 2>/dev/null | grep "^tree " | head -1 | sed 's/^tree //')
if [ -z "$tree" ]; then
    echo "Invalid commit"
    exit 1
fi

# Clear working directory and write tree
git-core cat-file -p "$tree" | while read mode sha1 name; do
    mkdir -p "$(dirname "$name")"
    git-core cat-file -p "$sha1" > "$name"
    chmod "$mode" "$name"
done

git-core update-ref HEAD "$sha1"
echo "Switched to $target"