#!/usr/bin/env bash
source build.sh
#change into test directory
cd test-area
echo "clean off old test data."
find ./out/ -type f -not -name '.gitignore' -delete
echo "done cleaning off old test data."
#run test
docker run --env templatedirectory=/template --env schemafilename=infrastructureSchema.json --env configfile=/data/infrastructureConfig.yaml -v ./config:/data -v ./out:/output -i -t $(echo "$REGISTRY/cluster-crafter:$TAG")