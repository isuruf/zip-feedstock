#!/usr/bin/env bash

set -eux

export CFLAGS="${CFLAGS} -DLARGE_FILE_SUPPORT -DZIP64_SUPPORT" \
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"

mkdir -p bzip2

# patch in default conda-forge compiler flags
sed -i unix/Makefile -e "s|^CFLAGS_NOOPT =|CFLAGS_NOOPT = $CFLAGS $CPPFLAGS |"
sed -i unix/configure -e "s|^LFLAGS1=''|LFLAGS1='$LDFLAGS'|"

# apply security patches from fedora
patch -p1 -i zip-3.0-currdir.patch
patch -p1 -i zip-3.0-exec-shield.patch
patch -p1 -i zip-3.0-format-security.patch
patch -p1 -i zipnote.patch

make -f unix/Makefile generic prefix="${PREFIX}" CC="${CC}" CPP="${CC_FOR_BUILD} -E" install
