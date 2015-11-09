#!/bin/bash
set -e

docker build -t desource/wrk2 -f Dockerfile .
docker tag -f desource/wrk2 quay.io/desource/wrk2
