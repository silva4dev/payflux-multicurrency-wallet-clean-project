#!/bin/sh

set -e

go mod tidy

go install github.com/cespare/reflex@latest

go install -tags "mysql" github.com/golang-migrate/migrate/v4/cmd/migrate@v4.14.1

migrate -path ./db/migrate -database "mysql://root:root@tcp(wallet-mysql:3306)/wallet?parseTime=true" up

go run db/seeds.go

reflex -c reflex.conf