#!/usr/bin/env sh

echo $NODE_NAME
echo $PIPELINE_NODE
echo $NODE_LABELS
echo $RESERVE
echo $PWD
set -ex
echo "$BRANCH_NAME"

make clean
make wheel

NAME=quartic_ansible_runner
VERSION=$(awk '$1 == "__version__" {print $NF}' ./ansible_runner/_version.py | sed "s/'//g")
OS=none
CPU_ARCH=any

WHEEL_FILENAME="$NAME-$VERSION-py3-$OS-$CPU_ARCH.whl"
CODE=$(curl -sS -w '%{http_code}' -F package="@dist/$WHEEL_FILENAME" -o output.txt "https://$GEMFURY_AUTH_TOKEN@push.fury.io/quartic-ai/")
cat output.txt && rm -rf output.txt
if [[ "$CODE" =~ ^2 ]]; then
    echo "$WHEEL_FILENAME Package published successfully"
else
    echo "ERROR: server returned HTTP code $CODE"
    exit 1
fi