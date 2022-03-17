#!/bin/bash

set -euxo pipefail

git_clone_dir=$(mktemp -d -t git-clone-XXXXXXXXXX)
root_dir=fork

rm -r $root_dir
rm go.sum

git clone --depth 1 https://github.com/cilium/ebpf $git_clone_dir

cp -r "$git_clone_dir/internal" .
mv internal $root_dir

find $root_dir -type f -name "*_test.go" -exec rm -rf {} \;
rm -r "$root_dir/btf/testdata"
rm -r "$root_dir/testutils"
rm -r "$root_dir/cmd"

find $root_dir -type f -name "*.go" -exec sed -i "" "s|github.com/cilium/ebpf/internal|github.com/paulcacheux/cilium-btf/fork|g" {} \;

go mod tidy

sudo rm -r "$git_clone_dir"