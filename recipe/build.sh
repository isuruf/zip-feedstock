#!/bin/bash

make -f unix/Makefile generic CC=$CC CPP=$CPP
mkdir -p $PREFIX/bin
mv zip $PREFIX/bin
