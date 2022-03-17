#!/bin/bash

set -euxo pipefail

git_clone_dir=$(mktemp -d -t git-clone-XXXXXXXXXX)

shopt -s extglob
rm -rv !("go.mod"|"fetch-upstream.sh") || true
shopt -u extglob

git clone --depth 1 https://github.com/cilium/ebpf $git_clone_dir

cp -r "$git_clone_dir/internal/." .

find . -type f -name "*_test.go" -exec rm -rf {} \;
rm -r "btf/testdata"
rm -r "testutils"
rm -r "cmd"

upstream_mod="github.com/cilium/ebpf/internal"
replace_mod="github.com/DataDog/btf-internals"
find . -type f -name "*.go" -exec sed -i "" "s|$upstream_mod|$replace_mod|g" {} \;

go mod tidy

sudo rm -r "$git_clone_dir"