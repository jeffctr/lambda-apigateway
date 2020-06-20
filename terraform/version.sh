#! /usr/bin/env sh

commit=$(git show HEAD --pretty=format:"%h" --no-patch)
tag=$(git tag -l --points-at HEAD)

echo "{\"commit\": \"$commit\", \"tag\": \"$tag\"}"
