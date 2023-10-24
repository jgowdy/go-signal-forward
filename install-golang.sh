#!/bin/bash

case $(uname -m) in
    aarch64)
        ;&
    arm64)
        ARCH=arm64
        ;;
    x86_64)
        ARCH=amd64
        ;;
    *)
        echo "Unknown machine type: $(uname -m)"
        exit 1
        ;;
esac

rm -f go1.21.3.linux-${ARCH}.tar.gz
wget https://go.dev/dl/go1.21.3.linux-${ARCH}.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.3.linux-${ARCH}.tar.gz
