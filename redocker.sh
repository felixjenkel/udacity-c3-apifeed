#!/bin/bash

docker build . -t udacity-3-apifeed:latest
docker tag udacity-3-apifeed:latest fjenkel/udacity-3-apifeed:latest
docker push fjenkel/udacity-3-apifeed:latest