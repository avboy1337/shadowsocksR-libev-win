#!/usr/bin/env bash
git submodule update --init

cd libudns
./autogen.sh
./configure
make -j2
cd ..

./autogen.sh
CFLAGS+="-static -Wall -O3 -pipe -Wno-format-truncation -Wno-error=format-overflow -Wno-error=pointer-arith -Wno-error=stringop-truncation -Wno-error=sizeof-pointer-memaccess -fstack-protector" ./configure --disable-documentation --with-ev="${PWD}/../../build"

sed -i "s/%I/%z/g" src/utils.h
sed -i "s/^const/extern const/g" src/tls.h
sed -i "s/^const/extern const/g" src/http.h

make -j8

gcc $(find src/ -name "ss_local-*.o") $(find . -name "*.a" ! -name "*.dll.a") "${PWD}/../../build/lib/libev.a" -o ss-local -fstack-protector -static -lpcre -lssl -lcrypto -lws2_32 -s