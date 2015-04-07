#!/bin/bash
./config --prefix=$PWD/openssl-build no-shared
make
make install
fpm -t deb -s dir --name openssl-build \
    -v 1.0.2a \
    --vendor "Adallom" \
    --url "https://github.com/Adallom/openssl" \
    --prefix "/opt" \
    --deb-field "Branch: $(git rev-parse --abbrev-ref HEAD)" \
    --deb-field "Commit: $(git rev-parse HEAD)" \
    -m "greg@adallom.com" \
    --description "Openssl binary archive package for static linking" \
    openssl-build

