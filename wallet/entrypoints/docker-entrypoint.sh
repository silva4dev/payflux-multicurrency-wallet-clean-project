#!/bin/sh

set -e

go mod tidy

go run cmd/walletcore/main.go