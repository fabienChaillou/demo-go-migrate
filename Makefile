
.PHONY: postgres createdb dropdb migrateup migratedown

DATABASE = "postgresql://root:secret@localhost:5432/moc_migrate?sslmode=disable"

## help: Display list of commands
.PHONY: help
help: Makefile
	@sed -n 's|^##||p' $< | column -t -s ':' | sort

## run postgres 15 container
postgres:
    docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

## create database
createdb:
    docker exec -it postgres15 createdb --username=root --owner=root moc_migrate

## drop db
dropdb:
    docker exec -it postgres15 dropdb moc_migrate

## up migration
migrateup:
    migrate -path db/migration -database $(DATABASE) -verbose up

## down migration
migratedown:
    migrate -path db/migration -database $(DATABASE) -verbose down
