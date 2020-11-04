#!/bin/sh

set -e

HEAVYTHING_VERSION=$1
HEAVYTHING_URL="https://2ton.com.au/HeavyThing-${HEAVYTHING_VERSION}.tar.gz"

mkdir src
cd src
curl -sL "${HEAVYTHING_URL}" | tar xzf - --strip-components=1

cd rwasa
fasm -m 1048576 rwasa.asm
ld -o rwasa rwasa.o

cp rwasa ../..

exit 0
