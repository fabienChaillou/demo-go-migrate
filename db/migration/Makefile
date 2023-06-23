DATABASE = "postgresql://root:secret@localhost:5432/moc_migrate?sslmode=disable"

## help: Display list of commands
.PHONY help
help: Makefile
#	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@sed -n 's|^##||p' $< | column -t -s ':' | sort

## run postgres 15 container
.PHONY postgres
postgres:
	@docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

## create database
.PHONY createdb
createdb:
	@docker exec -it postgres15 createdb --username=root --owner=root moc_migrate

## drop db
.PHONY dropdb
dropdb:
	@docker exec -it postgres15 dropdb moc_migrate

## up migration
.PHONY migrateup
migrateup:
	@migrate -path db/migration -database $(DATABASE) -verbose up

## down migration
.PHONY migratedown
migratedown:
	@migrate -path db/migration -database $(DATABASE) -verbose down
