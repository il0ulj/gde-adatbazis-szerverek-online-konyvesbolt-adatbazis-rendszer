#!/bin/bash

for file in *.sql; do
	PGPASSWORD=postgres psql -U postgres -h localhost < $file
done
