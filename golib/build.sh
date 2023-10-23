#!/bin/bash

CGO_ENABLED=1 GODEBUG=cgocheck=0 go build -v -buildmode=c-archive -ldflags='-s -w' -o ../node-addon/golib.a
