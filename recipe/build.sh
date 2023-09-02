#!/usr/bin/env bash

set -eux

# apply patches from fedora
patch -p1 -i zip-3.0-currdir.patch
patch -p1 -i zip-3.0-exec-shield.patch
patch -p1 -i zip-3.0-format-security.patch
patch -p1 -i zipnote.patch

make -f unix/Makefile \
  generic \
  prefix="${PREFIX}" \
  CC="${CC}" \
  CPP="${CXX}" \
  LARGE_FILE_SUPPORT=1 \
  ZIP64_SUPPORT=1 \
  install
