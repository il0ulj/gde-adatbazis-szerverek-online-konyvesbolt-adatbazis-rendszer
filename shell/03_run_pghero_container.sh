#!/bin/bash

ip=$(ip route get 8.8.8.8 | grep src | awk '{print $7}')

docker run -d --add-host=host.docker.internal:$ip --name pghero -e DATABASE_URL=postgres://postgres:postgres@host.docker.internal:5432/konyvesbolt -p 8080:8080 ankane/pghero
