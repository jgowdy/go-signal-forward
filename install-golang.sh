#!/bin/bash

GOVERSION=1.21.3

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

rm -f go${GOVERSION}.linux-${ARCH}.tar.gz
wget https://go.dev/dl/go${GOVERSION}.linux-${ARCH}.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GOVERSION}.linux-${ARCH}.tar.gz
rm -f go${GOVERSION}.linux-${ARCH}.tar.gz
