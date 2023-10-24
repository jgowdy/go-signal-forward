#!/bin/bash

pushd node-addon || exit 1

case $(uname -m) in
    aarch64)
        rm -f golib.a golib.h
        ln -s golib-arm64.a golib.a
        ln -s golib-arm64.h golib.h
        ;;
    arm64)
        rm -f golib.a golib.h
        ln -s golib-arm64.a golib.a
        ln -s golib-arm64.h golib.h
        ;;
    x86_64)
        rm -f golib.a golib.h
        ln -s golib-amd64.a golib.a
        ln -s golib-amd64.h golib.h
        ;;
    *)
        echo "Unknown machine type: $(uname -m)"
        exit 1
        ;;
esac

popd || exit 1
