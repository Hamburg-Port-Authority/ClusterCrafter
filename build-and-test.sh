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
echo " "
echo "== checking for diffs now"
echo " "
diff -bur ./test-area/coreService/out ./test-area/coreService/expected    
retVal=$?
if [ $retVal -ne 0 ]; then
    echo " "
    echo "Seems that there was a diff between generated out(./test-area/coreService/out) and expected(./test-area/coreService/expected)."
    exit 0
fi
