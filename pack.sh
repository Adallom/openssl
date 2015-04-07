#!/bin/bash
./config --prefix=$PWD/openssl-build/.openssl no-shared
make
make install

# HACK: These dummy files are required for the nginx --with-openssl configure script
echo -ne "#!/bin/bash\necho Dummy\n" > $PWD/openssl-build/config
chmod +x $PWD/openssl-build/config
echo -ne "install:\n\techo Dummy\nclean:\n\techo Dummy\n" > $PWD/openssl-build/Makefile

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

