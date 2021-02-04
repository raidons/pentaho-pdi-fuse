#!/bin/bash

# Configuration checks
if [ -z "${GCSFUSE_BUCKET}" ]; then
    echo "Error: GCSFUSE_BUCKET is not specified"
    exit 128
fi
# Write auth file if it does not exist
if [ -z "${GOOGLE_APPLICATION_CREDENTIALS_JSON}" ]; then
    echo "Error: Missing GOOGLE_APPLICATION_CREDENTIALS_JSON or ${GOOGLE_APPLICATION_CREDENTIALS} not provided"
    exit 128
fi

echo "==> [picoded/gcsfuse] : Mounting GCS Filesystem"
mkdir -p ${GCSFUSE_MOUNT}
gcsfuse $GCSFUSE_ARGS --key-file=/data-integration/$GOOGLE_APPLICATION_CREDENTIALS_JSON ${GCSFUSE_BUCKET} ${GCSFUSE_MOUNT}
echo "==> [picoded/gcsfuse] : Entrypoint Chain"
exec "$@"