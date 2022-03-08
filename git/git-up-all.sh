#!/bin/bash

set -e
set -o pipefail

NOCOLOR='\033[0m'
PURPLE='\033[0;35m'
LIGHTPURPLE='\033[1;35m'

function log() {
    echo -e "${LIGHTPURPLE}==> ${PURPLE}${1}${NOCOLOR}"
}

function git_up() {
    (
        log "change directory to $1..."
        cd $1
        log "$1: stashing any changes you may have..."
        stash_msg=$(git stash)
        log "$1: checking out master..."
        git co master
        log "$1: pulling and pruning..."
        git pull && git remote prune origin
        log "$1: checkout out your original branch..."
        git co -
        if [[ $stash_msg != "No local changes to save" ]]; then
            log "$1: applying any changes stashed.."
            git stash apply
        fi
    )
}

repos=$(find . -type d -name ".git" | sed "s#/\.git##")

for repo in $repos
do
    git_up $repo
done

