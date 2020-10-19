#!/bin/bash

# This file is used for convenience of local development.
# DO NOT STORE YOUR CREDENTIALS INTO GIT

docker kill my-test-db
docker kill udacity-api-feed

export POSTGRES_USERNAME=postgres
export POSTGRES_PASSWORD=postgres
export POSTGRES_HOST=localhost
export POSTGRES_DB=postgres
export AWS_BUCKET=test-udacity-course3-felix
export AWS_REGION=eu-west-1
export AWS_PROFILE=udacity_felix
export JWT_SECRET=test
export URL=http://localhost:8080


docker run \
    --network=host \
    -d \
    --rm \
    --name my-test-db \
    -p 5432:5432 \
    -e POSTGRES_USERNAME \
    -e POSTGRES_PASSWORD \
    -e POSTGRES_DB \
    postgres:alpine \
    -c shared_buffers=500MB \
    -c fsync=off

sleep 2

docker run \
    --network=host \
    -d \
    --rm \
    --name udacity-api-feed \
    -p 8080:8080 \
    -e POSTGRES_USERNAME \
    -e POSTGRES_PASSWORD \
    -e POSTGRES_HOST \
    -e POSTGRES_DB \
    -e AWS_BUCKET \
    -e AWS_REGION \
    -e AWS_PROFILE \
    -e JWT_SECRET \
    -e URL \
    udacity-api-feed:latest