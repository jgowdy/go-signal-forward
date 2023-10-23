#!/bin/bash
pushd golib || exit 1
./build.sh
popd || exit 1

pushd node-addon || exit 1
npm install
popd || exit 1

pushd node-app || exit 1
npm install
node .
popd || exit 1
