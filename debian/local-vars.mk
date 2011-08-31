############################ -*- Mode: Makefile -*- ###########################
## local-vars.mk --- 
## Author           : Manoj Srivastava ( srivasta@glaurung.green-gryphon.com ) 
## Created On       : Sat Nov 15 10:43:00 2003
## Created On Node  : glaurung.green-gryphon.com
## Last Modified By : Manoj Srivastava
## Last Modified On : Sat Aug 12 02:07:40 2006
## Last Machine Used: glaurung.internal.golden-gryphon.com
## Update Count     : 25
## Status           : Unknown, Use with caution!
## HISTORY          : 
## Description      : 
## 
## arch-tag: 1a76a87e-7af5-424a-a30d-61660c8f243e
## 
###############################################################################

FILES_TO_CLEAN  = debian/files debian/substvars substvars.utils src/semanageswig_ruby_wrap.lo \
                  src/_rubysemanage.so
STAMPS_TO_CLEAN = 
DIRS_TO_CLEAN   =  debian/stamp

# Location of the source dir
SRCTOP    := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
TMPTOP     = $(SRCTOP)/debian/$(package)
LINTIANDIR = $(TMPTOP)/usr/share/lintian/overrides

PREFIX  = /usr
BINDIR  = $(TMPTOP)$(PREFIX)/bin
LIBDIR  = $(TMPTOP)/usr/lib
INCLUDE = $(TMPTOP)$(PREFIX)/include
INCDIR  = $(INCLUDE)/semanage
ETCDIR  = $(TMPTOP)/etc/selinux
PKGDIR  = $(TMPTOP)/usr/lib/pkgconfig

MANDIR  = $(TMPTOP)/usr/share/man/
MAN1DIR = $(TMPTOP)/usr/share/man/man1
MAN3DIR = $(TMPTOP)/usr/share/man/man3
MAN5DIR = $(TMPTOP)/usr/share/man/man5
MAN7DIR = $(TMPTOP)/usr/share/man/man7
MAN8DIR = $(TMPTOP)/usr/share/man/man8
INFODIR = $(TMPTOP)/usr/share/info
DOCTOP  = $(TMPTOP)/usr/share/doc
DOCDIR  = $(DOCTOP)/$(package)
COMMA   = ,

PY_SUPPORT_DIR=$(LIBDIR)/python-support/$(package)

PY_VERSIONS    =>= 2.4
PYDEFAULT      =$(strip $(shell pyversions -vd))
ALL_PY_VERSIONS:=$(sort $(shell pyversions -vr))
MIN_PY_VERSIONS:=$(firstword $(sort $(shell pyversions -vr)))
MAX_PY_VERSIONS:=$(lastword  $(sort $(shell pyversions -vr)))
STOP_VERSION   :=$(shell perl -e '$$ARGV[0] =~ m/^(\d)\.(\d)/;$$maj=$$1;$$min=$$2 +1; print "$$maj.$$min\n";' $(MAX_PY_VERSIONS))

PY_VIRTUALS    :=$(patsubst %,%-semanage$(strip $(COMMA)),$(sort $(shell pyversions -r)))
PY_PROVIDES    :=$(strip $(shell pyversions -r |                                        \
                        perl -ple 's/(\d) p/$$1-semanage, p/g; s/$$/-semanage/'))

MODULES_DIR=$(TMPTOP)/usr/share/python-support/$(package)
EXTENSIONS_DIR=$(TMPTOP)/usr/lib/python-support/$(package)
PYTHONLIBDIRTOP=/usr/lib/python-support/$(package)

SWIGCOUT= semanageswig_wrap.c
SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT)) 
SWIGSO=_semanage.so

RUBYLIBVER ?= $(shell ruby -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
RUBYPLATFORM ?= $(shell ruby -e 'print RUBY_PLATFORM')
RUBYINC ?= $(TMPTOP)/usr/lib/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
RUBYINSTALL ?= $(TMPTOP)/usr/lib/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)


define checkdir
	@test -f debian/rules -a -f src/semanage.conf || \
          (echo Not in correct source directory; exit 1)
endef

define checkroot
	@test $$(id -u) = 0 || (echo need root priviledges; exit 1)
endef
