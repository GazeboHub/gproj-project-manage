#!/bin/bash

## update.sh
##
##
## # Usage
##
## This script represents an 'update' hook for Git.
##
##
## ## Installation
##
## This script should be installed by the developer, such that the
## file would be installed with 'exec' permissions, to a file
##
##     ${SOURCE_TREE}/.git/hooks/update
##
## within a ${SOURCE_TREE} of a project, on each developer's local
## filesystem.
##
## Alternately, as in situations requiring multiple update checks,
## this script may be called from the souce tree's `update` hook
## script, as such.
##
##
## ## Usage Notes
##
## From the original author:
##
##   "Known caveat is that the '0000...' special case is not handled."
##
##
## # Purpose
##
## This script endeavors to check for unpublished changes in Git
## submodules, to prevent synchronization failure in projects using
## Git submodules.
##
##
## # See also
##
## * _"Pro Git"_
##
##     * Section 6.6, _Git Tools - Submodules_,
##       Available http://git-scm.com/book/en/Git-Tools-Submodules
##
##     * Section 7.3, _Customizing Git - Git Hooks_,
##       Available http://git-scm.com/book/en/Customizing-Git-Git-Hooks
##
## * Maual page, run-parts(8)
##
##
## # Metadata
##
## **Origin:** Refer to https://diigo.com/01e9eh
## **License:** Unspecified (assumed: Public Domain)
## **Editor:** Sean Champ <spchamp+gproj _@_ me.com>
## **Timestamp:** 8 December, 2013

# # Safety checks

# ## Command Line Checks
#
#  From default ${SOURCE_TREE}/.git/hooks/update.sample

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

# # Main Code
#
# The following is originally cf. https://diigo.com/01e9eh

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
