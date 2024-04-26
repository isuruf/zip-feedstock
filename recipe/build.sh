#!/usr/bin/env bash

set -eux

export CFLAGS="${CFLAGS} -DLARGE_FILE_SUPPORT -DZIP64_SUPPORT"

if [[ "$target_platform" == win-* ]]; then
  export CFLAGS="${CFLAGS} -DNO_UNISTD_H=1"
fi

mkdir -p bzip2

# patch in default conda-forge compiler flags
sed -i "s|^CFLAGS_NOOPT =|CFLAGS_NOOPT = $CFLAGS $CPPFLAGS |" unix/Makefile
sed -i "s|^LFLAGS1=''|LFLAGS1='$LDFLAGS'|" unix/configure

make -f unix/Makefile generic prefix="${PREFIX}" CC="${CC}" CPP="${CC} -E" install
