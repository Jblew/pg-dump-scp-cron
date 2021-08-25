#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"
set -e

BASE_TAG="jedrzejlewandowski/pg-dump-scp-cron"
VERSION="1.0.0"
PGTAG="pg13"

docker build -t "${BASE_TAG}" .
docker tag "${BASE_TAG}" "${BASE_TAG}:latest"
docker tag "${BASE_TAG}" "${BASE_TAG}:${PGTAG}"
docker tag "${BASE_TAG}" "${BASE_TAG}:${VERSION}"
docker push "${BASE_TAG}:latest"
docker push "${BASE_TAG}:${VERSION}"