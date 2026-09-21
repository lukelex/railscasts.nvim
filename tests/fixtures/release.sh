#!/usr/bin/env bash

set -euo pipefail

version="$1"

if [[ -z "$version" ]]; then
  echo "usage: release VERSION"
  exit 1
fi

git tag "v$version"
git push origin "v$version"
