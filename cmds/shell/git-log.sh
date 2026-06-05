#!/bin/bash
# git-log.sh

commit=$(git-core read-ref HEAD)
if [ -z "$commit" ]; then
    commit=$(git-core resolve-ref HEAD)
fi

while [ -n "$commit" ]; do
    obj=$(git-core cat-file -p "$commit" 2>/dev/null)
    if [ -z "$obj" ]; then
        break
    fi
    
    echo "commit $commit"
    echo "$obj" | while read line; do
        if [ -z "$line" ]; then
            break
        fi
        case "$line" in
            author*|committer*)
                echo "$line"
                ;;
        esac
    done
    echo
    echo "$obj" | sed '0,/^$/d' | sed 's/^/    /'
    echo
    
    # Get parent
    commit=$(echo "$obj" | grep "^parent " | head -1 | sed 's/^parent //')
done