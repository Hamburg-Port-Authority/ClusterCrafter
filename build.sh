#!/usr/bin/env bash
# check for all required executables
if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: docker is not installed.' >&2
  exit 1
fi
if ! [ -x "$(command -v mvn)" ]; then
  echo 'Error: maven is not installed.' >&2
  exit 1
fi
if ! [ -x "$(command -v java)" ]; then
  echo 'Error: java is not installed.' >&2
  exit 1
fi
# defaults
source getVersion.sh
REGISTRY="ghcr.io/hamburg-port-authority"
docker build ./ -f Dockerfile -t $(echo "$REGISTRY/cluster-crafter:$TAG")