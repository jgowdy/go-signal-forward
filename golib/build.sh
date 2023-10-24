#!/bin/bash
export CGO_ENABLED=1
export GODEBUG=cgocheck=0
                
case $(uname -s) in
    Darwin)
        case $(uname -m) in
            arm64)
                export GOOS=darwin
                export GOARCH=arm64
                export CC=clang
                ;;
            x86_64)
                export GOOS=darwin
                export GOARCH=x86_64
                export CC=clang
                ;;
            *)
                echo "Unknown machine type: $(uname -m)"
                exit 1
                ;;
        esac
        ;;
    Linux)
        case $(uname -m) in
            aarch64)
                sudo apt-get install build-essential gcc-x86-64-linux-gnu binutils-x86-64-linux-gnu wget -y
                if [ ! -f /usr/local/go/bin/go ]; then
                    rm -f go1.21.3.linux-arm64.tar.gz
                    wget https://go.dev/dl/go1.21.3.linux-arm64.tar.gz
                    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.3.linux-arm64.tar.gz
                fi
                PATH=$PATH:/usr/local/go/bin
                export GOOS=linux
                export GOARCH=arm64
                export ARM64_CC=gcc
                export AMD64_CC=x86_64-linux-gnu-gcc
                ;;
            x86_64)
                sudo apt-get install build-essential gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu wget -y
                if [ ! -f /usr/local/go/bin/go ]; then
                    rm -f go1.21.3.linux-amd64.tar.gz
                    wget https://go.dev/dl/go1.21.3.linux-amd64.tar.gz
                    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.3.linux-amd64.tar.gz
                fi
                PATH=$PATH:/usr/local/go/bin
                export GOOS=linux
                export GOARCH=amd64
                export AMD64_CC=gcc
                export ARM64_CC=aarch64-linux-gnu-gcc
                ;;
            *)
                echo "Unknown machine type: $(uname -m)"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Unknown system: $(uname -s)"
        exit 1
        ;;
esac

CC=${ARM64_CC} GOARCH=arm64 go build -v -buildmode=c-archive -ldflags='-s -w' -o ../node-addon/golib-arm64.a
CC=${AMD64_CC} GOARCH=amd64 go build -v -buildmode=c-archive -ldflags='-s -w' -o ../node-addon/golib-amd64.a

case $(uname -m) in
    aarch64)
        rm -f ../node-addon/golib.a
        ln -s golib-arm64.a ../node-addon/golib.a
        ln -s golib-arm64.h ../node-addon/golib.h
        ;;
    arm64)
        rm -f ../node-addon/golib.a
        ln -s golib-arm64.a ../node-addon/golib.a
        ln -s golib-arm64.h ../node-addon/golib.h
        ;;
    x86_64)
        rm -f ../node-addon/golib.a
        ln -s golib-amd64.a ../node-addon/golib.a
        ln -s golib-amd64.h ../node-addon/golib.h
        ;;
    *)
        echo "Unknown machine type: $(uname -m)"
        exit 1
        ;;
esac
