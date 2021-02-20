#! /bin/sh -l

REMOTE="${1}"

git clone --bare "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" .
git remote add --mirror=fetch mirror "${REMOTE}"
git fetch mirror +refs/heads/*:refs/remotes/origin/*
git push --force --mirror --prune origin
