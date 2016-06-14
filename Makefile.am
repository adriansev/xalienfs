#######################################################################
## Makefile.am for xAlien FS plugin
##
##
## Version info: $Id: Makefile.am,v 1.5 2006/07/24 07:38:57 apeters Exp $
## Checked in by $Author: apeters $
#######################################################################

if BUILD_SERVER
  SERVER_DIR = server
endif

ACLOCAL_AMFLAGS = -I m4

SUBDIRS = base client $(SERVER_DIR)

AM_CPPFLAGS = -I$(XROOTD_LOCATION)/include/xrootd -I$(ALIEN_LOCATION) $(OPTIM) $(DEBUG)

EXTRA_DIST = configure.ac bootstrap.sh  xrootd-xalienfs.spec base/debugmacros.h acinclude.m4 server/scripts/AlienAS.pl server/scripts/gapiserver.pl server/scripts/gapiservermonitor.pl server/etc/gapiservice.cfg.xml client/clients/share client/gclientlib/perl/gapi.pm client/gclientlib/perl/Makefile.PL client/gclientlib/perl/gapiUI.i client/gclientlib/perl/gapiUI.pm

