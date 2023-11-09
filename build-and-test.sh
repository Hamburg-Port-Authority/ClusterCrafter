#!/usr/bin/env bash
source build.sh

# RUN TEST #1 (coreService)

echo "clean off old test data."
find ./test-area/coreService/out -type f -not -name '.gitignore' -delete
echo "done cleaning off old test data."

docker run \
    --env templatedirectory=/template/overlay/coreService \
    --env schemafilename=coreServiceSchema.json \
    --env configfile=/data/coreServiceConfig.yaml \
    -v ./test-area/coreService/config:/data \
    -v ./test-area/coreService/out:/output \
    -i -t $(echo "$REGISTRY/cluster-crafter:$TAG")

diff -bur ./test-area/coreService/out ./test-area/coreService/expected    