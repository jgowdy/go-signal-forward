#!/bin/bash

pushd node-app || exit 1
npm install || exit 1

DISTRO=$(cut -d\\ -f1 < /etc/issue)

case $(uname -s) in
    Darwin)
        printf "\n\nRunning on macOS\n"
        ;;
    Linux)
        printf "\n\nRunning on Linux - %s\n" "$DISTRO"
        ;;
    *)
        echo "Unknown system: $(uname -s)"
        exit 1
        ;;
esac

case $(uname -m) in
    aarch64)
        ;&
    arm64)
        printf "Running on ARM64\n"
        ;;
    x86_64)
        printf "Running on AMD64\n"
        ;;
    *)
        echo "Unknown machine type: $(uname -m)"
        exit 1
        ;;
esac

printf "\n\nRunning with BAD_STACK_TRACE=false\n\n"
BAD_STACK_TRACE=false node .
printf "\n\nRunning with BAD_STACK_TRACE=true\n\n"
BAD_STACK_TRACE=true node .
popd || exit 1
