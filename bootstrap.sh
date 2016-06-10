#!/bin/sh
autoreconf --install
libtoolize --copy --force
autoheader
aclocal
automake -acf
autoconf

