#!/bin/bash

docker run -d --name postgres --restart always -p "5432:5432" -v "$PWD/postgresql.conf":/etc/postgresql/postgresql.conf -e POSTGRES_PASSWORD=postgres postgres postgres -c "config_file=/etc/postgresql/postgresql.conf"
