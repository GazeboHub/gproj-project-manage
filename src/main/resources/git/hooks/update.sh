#!/bin/bash

## # Usage
##
## This script represents an 'update' hook for Git.
##
## This script should be installed by the developer, such that the
## file is installed with 'exec' permissions, to the location
##   ${SOURCE_TREE}/.git/hooks/update
## or called from a script installed there.
##
## # Purpose
##
## This script endeavors to check for unpublished changes in Git
## submodules, to prevent synchronization failure in projects using
## Git submodules.
##
## See also, "Pro Git", section 6.6 _Git Tools - Submodules_
##
## # Metadata
##
## **Origin:** Refer to https://diigo.com/01e9eh
## **License:** Unspecified (Public Domain)
## **Editor:** Sean Champ <spchamp+gproj _@_ me.com>

## Safety checks

### From default ${SOURCE_TREE}/.git/hooks/update.sample

if [ -z "$GIT_DIR" ]; then
        echo "Don't run this script from the command line." >&2
        echo " (if you want, you could supply GIT_DIR then run" >&2
        echo "  $0 <ref> <oldrev> <newrev>)" >&2
        exit 1
fi

if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
        echo "usage: $0 <ref> <oldrev> <newrev>" >&2
        exit 1
fi

## The following is originally cf. https://diigo.com/01e9eh

REF=$1
OLD=$2
NEW=$3

# This update hook is based on the following information:
# http://stackoverflow.com/questions/3418674/bash-shell-script-function-to-verify-git-tag-or-commit-exists-and-has-been-pushe

# Get a list of submodules
git config --file <(git show $NEW:.gitmodules) \
    --get-regexp 'submodule..*.path' |
    while read key path
        do
            url=$(git config --file <(git show $NEW:.gitmodules) \
                      --get "${key/.path/.url}")
            git diff "$OLD..$NEW" -- "$path" |
                grep -e '^+Subproject commit ' |
                cut -f3 -d ' ' |
          while read new_rev
            do
                LINES=$(GIT_DIR="$url" git branch --quiet \
                                           --contains "$new_rev" 2>/dev/null |
                                       wc -l)
                if [ $LINES == 0 ]
                then
                    echo "Commit $new_rev not found in submodule $path ($url)" >&2
                    echo "Please push that submodule first" >&2
                    exit 1
                fi
            done || exit 1
    done || exit 1

exit 0
