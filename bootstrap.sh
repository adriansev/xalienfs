#!/bin/sh
libtoolize --copy --force
autoreconf --install
autoheader
aclocal
automake -acf
autoconf

