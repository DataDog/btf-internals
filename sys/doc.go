// Package sys contains bindings for the BPF syscall.
package sys

// Regenerate types.go by invoking go generate in the current directory.

//go:generate go run github.com/DataDog/btf-internals/cmd/gentypes ../btf/testdata/vmlinux-btf.gz
