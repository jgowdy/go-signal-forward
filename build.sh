#!/bin/bash

./clean.sh

pushd golib || exit 1
./build.sh || exit 1
popd || exit 1

pushd node-addon || exit 1
npm install || exit 1
popd || exit 1
