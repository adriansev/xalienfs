AC_PREREQ(2.57)
AC_INIT(xrootd-xalienfs, 1.0.140,[andreas.joachim.peters@cern.ch])
AC_CONFIG_SRCDIR([server/XrdxAlienFs.cc])
AM_CONFIG_HEADER(config.h)
AC_CANONICAL_TARGET
AM_INIT_AUTOMAKE([1.6.3 subdir-objects])

AC_CONFIG_MACRO_DIR([m4])

DEBUG="-g -pg -ggdb"
OPTIM="-O2"

#ERROR="-Werror"

CXXFLAGS="-Wall -Wno-deprecated -std=gnu++98 $ERROR $DEBUG $OPTIM $CXXFLAGS"

case "$target_os" in
   tiger*)
#     AC_DEFINE(__macos__,[],[define macos])
     ;;
   darwin*)
#     AC_DEFINE(__macos__,[],[define macos])
     ;;
   apple*)
#     AC_DEFINE(__macos__,[],[define macos])
     ;;
   linux*)
     # TODO: check why two different macros are used for this
#     AC_DEFINE(__linux__,[],[define linux])
#     AC_DEFINE(__linux,[],[define linux])
     ;;
   solaris*)
#     AC_DEFINE(__sun,[],[define sun])
     CC_PREFERENCE="cc gcc"
     CXX_PREFERENCE="CC g++"
     DFLT_OPT="-O2"
     ;;
   *)
     AC_MSG_WARN([untested operating system])
   ;;
esac

libversion=`libtoolize --version | head -1  | cut -d " " -f 4`
case "$target_os" in
   darwin*)
   if test "x$libversion" = "x1.5.22"; then
      AC_MSG_ERROR([broken libtool version $libversion found on this MAC - install newer one from http://www.gnu.org/software/libtool/news.html])
   fi
   ;;
esac


## Assume always 64 bit systems
MARK64=64

AC_SUBST(MARK64)

AC_ARG_WITH(xrootd-location,
          [  --with-xrootd-location=installation of xrootd version to use],
          [XROOTD_LOCATION=$withval],
          [XROOTD_LOCATION=/usr/])

AC_SUBST(XROOTD_LOCATION)

AC_ARG_WITH(certificate-directory,
          [  --with-certificate-directory=installation of grid certificates for verification to use],
          [CERTIFICATE_LOCATION=$withval],
          [CERTIFICATE_LOCATION=/etc/grid-security/certificates/])

AC_SUBST(CERTIFICATE_LOCATION)

AC_ARG_WITH(alien-location,
          [  --with-alien-location=installation of alien version to use],
          [ALIEN_LOCATION=$withval],
          [ALIEN_LOCATION=/usr/])

AC_SUBST(ALIEN_LOCATION)

#AC_DEFINE(_LARGEFILE_SOURCE,[],[use large files])
#AC_DEFINE(_FILE_OFFSET_BITS,64)
#AC_DEFINE(_GNU_SOURCE,[],[declare GNU_SOURCE])

AC_SYS_LARGEFILE


# Checks for programs.
AC_PROG_CXX
AC_PROG_AWK
AC_PROG_CC
AC_PROG_CPP
AM_PROG_CC_C_O
AC_PROG_INSTALL
AC_PROG_LN_S
AM_PROG_LEX
AC_PROG_YACC
AC_PROG_LIBTOOL
AC_CHECK_PROG([HAVEDOXYGEN],[doxygen],[yes],[no])
AM_CONDITIONAL(WITHDOXYGEN, test x"$HAVEDOXYGEN" = xyes)

# Checks for header files.
AC_HEADER_STDC
AC_HEADER_SYS_WAIT
AC_CHECK_HEADERS([arpa/inet.h fcntl.h float.h limits.h netdb.h netinet/in.h stdlib.h string.h strings.h sys/socket.h sys/time.h sys/timeb.h unistd.h])

# extend the preprocessor and link PATHs to the Vars provided by ACX_LIBOPTION

AC_ARG_WITH([readline],
  [AS_HELP_STRING([--with-readline],
  [support fancy command line editing @<:@default=check@:>@])],
  [],
  [with_readline=check])

READLINE_LIBS=
  AS_IF([test "x$with_readline" != xno],
  [AC_CHECK_LIB([readline], [main],
    [AC_SUBST([LIBREADLINE], ["-lreadline -lncurses"])
      AC_DEFINE([HAVE_LIBREADLINE], [1],
      [Define if you have libreadline])
    ],
  [if test "x$with_readline" != xcheck; then
    AC_MSG_FAILURE(
    [--with-readline was given, but test for readline failed])
    fi
  ], -lncurses)])


#CPPFLAGS="$READLINE_INCDIR $CPPFLAGS"
#LDFLAGS="$READLINE_LIBDIR $LDFLAGS"
AC_SUBST(READLINE_LIBS)

CPPFLAGS="$CPPFLAGS_BUP"
LDFLAGS="$LDFLAGS_BUP"
SHELL_LIBS="$READLINE_LIBS"

AC_SUBST(SHELL_LIBS)
AC_SUBST(HAVE_READLINE)

AC_ARG_ENABLE(build-server,
	     [  --enable-build-server  compile also the server part],
  if test x"$enableval" = xyes
  then
    build_server=yes
  fi )

AM_CONDITIONAL([BUILD_SERVER], [test "$build_server" = yes])

if test x"$build_server" = xyes
then

#################################################################
# PERL options
AC_ARG_WITH(perl,
            [  --with-perl = path to perl executable],
            PERL=$withval,
            PERL=/usr/bin/perl)
AC_SUBST(PERL)

# get the correct library options and link flags for perl
AC_MSG_CHECKING([perl libraries and link options])
perlbuf=`${PERL} -MExtUtils::Embed -e ldopts`

if test x"$perlbuf" = x
then
  AC_MSG_ERROR([no result from ${PERL} -MExtUtils::Embed -e ldopts])
fi

AC_MSG_RESULT($perlbuf)
for name in $perlbuf
do
  case $name in
    -L*)
      PERL_LIBS="${PERL_LIBS} $name"
      ;;
    -l*)
      PERL_LIBS="${PERL_LIBS} $name"
      ;;
     *.a)
      PERL_LIBS="${PERL_LIBS} $name"
      ;;
    *)
      PERL_LDOPTS="${PERL_LDOPTS} $name"
      ;;
  esac
done

AC_MSG_NOTICE([perlembed libraries to link: $PERL_LIBS])
AC_MSG_NOTICE([perlembed link flags: $PERL_LDOPTS])
PERL_CCOPTS=`${PERL} -MExtUtils::Embed -e ccopts`
AC_MSG_NOTICE([perlembed cc options: $PERL_CCOPTS])
AC_SUBST(PERL_LIBS)
AC_SUBST(PERL_LDOPTS)
AC_SUBST(PERL_CCOPTS)

fi


#################################################################
# PERLMODULE options
AC_ARG_ENABLE(perl-module,
            [  --enable-perl-module     enables building of the client perl module],
	    enable_perlmodule="1",
	    enable_perlmodule="")

AM_CONDITIONAL(ENABLE_PERLMODULE, test x"$enable_perlmodule" = x1)

if test x"$enable_perlmodule"  != x; then

AC_ARG_WITH(swig,
	    [  --with-swig=PATH  directory containing swig installation (e.g. <prefix>/bin/swig ..) ],
               [SWIG_DIR="/usr/"])

AC_PATH_PROG(SWIG,swig,[no],[$SWIG_DIR:$PATH])

if test x"$SWIG" = xno; then
  AC_MSG_ERROR([I was not able to find the swig executable needed for the perl client])
fi

fi # end of enable_perlmodule

#################################################################
# Cryptography options
#
# decides whether the AES machinery of OpenSSL (>=0.9.7) is to be
# used or the included AES implementation by Brian Gladman
AC_ARG_ENABLE(aes-openssl,
              [  --enable-aes-openssl   use OpenSSL AES implementation instead of Brian Gladman's],
 if test x"$enableval" = xyes
 then
    AC_DEFINE(USE_OPENSSL_AES,1,[use OpenSSL AES implementation])
    openssl_aes=1
 fi )
AM_CONDITIONAL(OPENSSL_AES, test x"$openssl_aes" = x1)


# Do all testing using C++
AC_LANG([C++])

# Checks for programs.
AC_PROG_CXX

dnl Disable libtool 1.5 support for languages we don't use
define([AC_LIBTOOL_LANG_F77_CONFIG], [:])dnl
define([AC_LIBTOOL_LANG_GCJ_CONFIG], [:])dnl
AC_PROG_LIBTOOL

AC_DEFINE(GPREFIX,["alien"],[prefix for grid shell commands])
AC_SUBST(GPREFIX,[alien])

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([sys/time.h])

# Check for xrootd headers
if ! test -e "$XROOTD_LOCATION/include/xrootd/XrdVersion.hh"
then
      AC_MSG_ERROR([xrootd header files could not be found])
fi


# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL
AC_C_CONST
AC_TYPE_MODE_T
AC_TYPE_SIZE_T
AC_HEADER_TIME

# Checks for library functions.
AC_FUNC_STAT
AC_CHECK_FUNCS([gettimeofday mkdir strdup])

AC_CONFIG_FILES([Makefile
		 server/Makefile
		 client/Makefile
		 base/Makefile
     client/gclientlib/Makefile
     client/clients/Makefile
     base/ShmAuth/Makefile
		 server/C2Perl/Makefile
		 base/CODEC/Makefile
     base/cwccrypt/Makefile
     base/cwccrypt/gaes/Makefile])

ln -s . server/XrdxAlienFs

echo "=================================================="
echo "Configuring for .../lib$MARK64 library directories"
echo "Using xrootd from ${XROOTD_LOCATION}              "
echo "=================================================="
AC_OUTPUT
