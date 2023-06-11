## push and run postgres images
````shell
docker pull postgres:15-alpine
docker run --name postgres15 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -p 5432:5432 -d postgres:15-alpine

docker exec -it postgres15 psql -U root
```

### Create db
`docker exec -it postgres15 createdb --username=root --owner=root moc_migration`

### init migrate
`migrate create -ext sql -dir db/migration -seq init_schema``

`export POSTGRESQL_URL='postgres://root:secret@localhost:5432/moc_migrate?sslmode=disable'`

## generate new sql migration
`migrate -database ${POSTGRESQL_URL} -path db/migrations up`
