############################ -*- Mode: Makefile -*- ###########################
## local.mk --- 
## Author           : Manoj Srivastava ( srivasta@glaurung.green-gryphon.com ) 
## Created On       : Sat Nov 15 10:42:10 2003
## Created On Node  : glaurung.green-gryphon.com
## Last Modified By : Manoj Srivastava
## Last Modified On : Tue Sep  1 23:29:47 2009
## Last Machine Used: anzu.internal.golden-gryphon.com
## Update Count     : 61
## Status           : Unknown, Use with caution!
## HISTORY          : 
## Description      : 
## 
## arch-tag: b07b1015-30ba-4b46-915f-78c776a808f4
## 
###############################################################################

testdir:
	$(testdir)

debian/stamp/BUILD/libsemanage1:     debian/stamp/build/libsemanage1
debian/stamp/INST/libsemanage1:      debian/stamp/install/libsemanage1
debian/stamp/BIN/libsemanage1:       debian/stamp/binary/libsemanage1

debian/stamp/INST/libsemanage-common: debian/stamp/install/libsemanage-common
debian/stamp/BIN/libsemanage-common:  debian/stamp/binary/libsemanage-common

debian/stamp/INST/libsemanage1-dev:  debian/stamp/install/libsemanage1-dev
debian/stamp/BIN/libsemanage1-dev:   debian/stamp/binary/libsemanage1-dev

debian/stamp/INST/python-semanage:   debian/stamp/install/python-semanage
debian/stamp/BIN/python-semanage:    debian/stamp/binary/python-semanage

debian/stamp/BUILD/libsemanage-ruby1.8: debian/stamp/build/libsemanage-ruby1.8
debian/stamp/INST/libsemanage-ruby1.8:  debian/stamp/install/libsemanage-ruby1.8
debian/stamp/BIN/libsemanage-ruby1.8:   debian/stamp/binary/libsemanage-ruby1.8


CLN-common::
	$(REASON)
	-test ! -f Makefile || $(MAKE) $(NUMJOBS) clean

CLEAN/libsemanage1-dev::
	test ! -d $(TMPTOP) || rm -rf $(TMPTOP)

CLEAN/libsemanage1::
	test ! -d $(TMPTOP) || rm -rf $(TMPTOP)

CLEAN/libsemanage-common::
	test ! -d $(TMPTOP) || rm -rf $(TMPTOP)

CLEAN/python-semanage::
	test ! -d $(TMPTOP) || rm -rf $(TMPTOP)

CLEAN/libsemanage-ruby1.8::
	test ! -d $(TMPTOP) || rm -rf $(TMPTOP)

debian/stamp/build/libsemanage1:
	$(checkdir)
	$(REASON)
	@test -d debian/stamp/build || mkdir -p debian/stamp/build
	$(MAKE) $(NUMJOBS) CC="$(CC)" CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" all
	$(check-libraries)
ifeq (,$(strip $(filter nocheck,$(DEB_BUILD_OPTIONS))))
  ifeq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
	$(SHELL) debian/common/get_shlib_ver
  endif
endif
	@echo done > $@

debian/stamp/build/libsemanage-ruby1.8:
	$(checkdir)
	$(REASON)
	@test -d debian/stamp/build || mkdir -p debian/stamp/build
	$(MAKE) $(NUMJOBS) -C src CC="$(CC)" CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" rubywrap
	$(check-libraries)
	@echo done > $@

debian/stamp/install/libsemanage1:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	rm -rf		    $(TMPTOP)
	$(make_directory)   $(TMPTOP)
	$(make_directory)   $(DOCDIR)
	$(make_directory)   $(LIBDIR)
	$(MAKE)		    $(NUMJOBS) DESTDIR=$(TMPTOP)  -C src  install
	test ! -d           $(PKGDIR)      || rm -rf $(PKGDIR)
	test ! -d           $(TMPTOP)/etc  || rm -rf $(TMPTOP)/etc
	chmod 0644          $(LIBDIR)/libsemanage.so.1
	rm -f 		    $(LIBDIR)/libsemanage.so
	rm -f 		    $(LIBDIR)/libsemanage.a
	$(install_file)	    debian/changelog	     $(DOCDIR)/changelog.Debian
	$(install_file)	    ChangeLog		     $(DOCDIR)/changelog
	gzip -9fqr	    $(DOCDIR)/
# Make sure the copyright file is not compressed
	$(install_file)	     debian/copyright	     $(DOCDIR)/copyright
	$(strip-lib)
	@test -d debian/stamp/install || mkdir -p debian/stamp/install
	@echo done > $@


debian/stamp/install/libsemanage-common:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	rm -rf		    $(TMPTOP)
	$(make_directory)   $(TMPTOP)
	$(make_directory)   $(DOCDIR)
	$(make_directory)   $(LIBDIR)
	$(MAKE)		    $(NUMJOBS) DESTDIR=$(TMPTOP)  -C src  install
	test ! -d           $(PKGDIR)  || rm -rf $(PKGDIR)
	test ! -d           $(LIBDIR)  || rm -rf $(LIBDIR)
	$(install_file)	    debian/changelog	     $(DOCDIR)/changelog.Debian
	$(install_file)	    ChangeLog		     $(DOCDIR)/changelog
	gzip -9fqr	    $(DOCDIR)/
# Make sure the copyright file is not compressed
	$(install_file)	     debian/copyright	     $(DOCDIR)/copyright
	@test -d debian/stamp/install || mkdir -p debian/stamp/install
	@echo done > $@


debian/stamp/install/libsemanage1-dev:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	rm -rf		    $(TMPTOP)
	$(make_directory)   $(TMPTOP)
	$(make_directory)   $(DOCDIR)
	$(make_directory)   $(LIBDIR)
	$(make_directory)   $(INCDIR)
	$(make_directory)   $(ETCDIR)
	$(MAKE)		    $(NUMJOBS) DESTDIR=$(TMPTOP)        install
	mv	            $(ETCDIR)/semanage.conf  $(DOCDIR)/
	rm -rf              $(TMPTOP)/etc
	rm -f               $(LIBDIR)/libsemanage.so.1  $(LIBDIR)/libsemanage.so
	ln -s                         libsemanage.so.1 	$(LIBDIR)/libsemanage.so
	$(install_file)	    debian/changelog	     	$(DOCDIR)/changelog.Debian
	$(install_file)	    ChangeLog		     	$(DOCDIR)/changelog
	gzip -9fqr	    $(DOCDIR)/
	gzip -9fqr	    $(MANDIR)/
# Make sure the copyright file is not compressed
	$(install_file)	     debian/copyright	     	$(DOCDIR)/copyright
	$(strip-exec)
	$(strip-lib)
	@test -d debian/stamp/install || mkdir -p debian/stamp/install
	@echo done > $@


debian/stamp/install/python-semanage:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	rm -rf		    $(TMPTOP)
	$(make_directory)   $(TMPTOP)
	$(make_directory)   $(DOCDIR)
	$(make_directory)   $(LIBDIR)
	$(make_directory)   $(PY_SUPPORT_DIR)
	$(make_directory)   $(MODULES_DIR)
	$(make_directory)   $(EXTENSIONS_DIR)
	for version in $(ALL_PY_VERSIONS); do                          \
          rm -f             src/$(SWIGSO) src/$(SWIGLOBJ);             \
	  test -d $(EXTENSIONS_DIR)/python$$version ||                 \
            mkdir -p $(EXTENSIONS_DIR)/python$$version/site-packages;  \
          $(MAKE) -C src DESTDIR=$(TMPTOP) PYLIBVER=python$$version    \
                  PYLIBDIR=$(EXTENSIONS_DIR)/python$$version           \
                  CC="$(CC)" CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"   \
                  $(NUMJOBS) pywrap install-pywrap;                    \
          chmod -x $(EXTENSIONS_DIR)/python$$version/site-packages/*;  \
          mv -f $(EXTENSIONS_DIR)/python$$version/site-packages/*.py   \
                $(MODULES_DIR)/;                                       \
          mv -f $(EXTENSIONS_DIR)/python$$version/site-packages/*      \
                $(EXTENSIONS_DIR)/python$$version/;                    \
	  rmdir $(EXTENSIONS_DIR)/python$$version/site-packages;       \
          if [ -z "$$versions" ]; then versions="$$version";           \
          else             versions="$$versions,$$version";            \
          fi;                                                          \
        done; echo "$$versions" > $(MODULES_DIR)/.version
	$(install_file)	    debian/changelog	     $(DOCDIR)/changelog.Debian
	$(install_file)	    ChangeLog		     $(DOCDIR)/changelog
	gzip -9fqr	    $(DOCDIR)/
# Make sure the copyright file is not compressed
	$(install_file)	     debian/copyright	     $(DOCDIR)/copyright
	$(strip-lib)
	@test -d debian/stamp/install || mkdir -p debian/stamp/install
	@echo done > $@

debian/stamp/install/libsemanage-ruby1.8:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	rm -rf		    $(TMPTOP)
	$(make_directory)   $(TMPTOP)
	$(make_directory)   $(DOCDIR)
	$(make_directory)   $(RUBYINSTALL)
	$(MAKE) -C src      $(NUMJOBS) DESTDIR=$(TMPTOP) RUBYINSTALL=$(RUBYINSTALL) install-rubywrap;
	$(install_file)	    debian/changelog	     $(DOCDIR)/changelog.Debian
	$(install_file)	    ChangeLog		     $(DOCDIR)/changelog
	gzip -9fqr	    $(DOCDIR)/
# Make sure the copyright file is not compressed
	$(install_file)	     debian/copyright	     $(DOCDIR)/copyright
	$(strip-lib)
	@test -d debian/stamp/install || mkdir -p debian/stamp/install
	@echo done > $@

debian/stamp/binary/libsemanage1:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	$(make_directory)    $(TMPTOP)/DEBIAN
	$(install_script)    debian/postrm           $(TMPTOP)/DEBIAN/postrm
	$(install_script)    debian/postinst         $(TMPTOP)/DEBIAN/postinst
	$(install_file)      debian/shlibs           $(TMPTOP)/DEBIAN
	dpkg-gensymbols      -p$(package)            -P$(TMPTOP) -c4
	$(get-shlib-deps)
	dpkg-gencontrol	     -p$(package) -isp	     -P$(TMPTOP)
	$(create_md5sum)     $(TMPTOP)
	chown -R root:root   $(TMPTOP)
	chmod -R u+w,go=rX   $(TMPTOP)
	dpkg --build	     $(TMPTOP) ..
	@test -d debian/stamp/binary || mkdir -p debian/stamp/binary
	@echo done > $@

debian/stamp/binary/libsemanage-common:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	$(make_directory)    $(TMPTOP)/DEBIAN
	$(install_script)    debian/common_postrm    $(TMPTOP)/DEBIAN/postrm
	$(install_file)      debian/conffiles        $(TMPTOP)/DEBIAN
	dpkg-gencontrol	     -p$(package) -isp	     -P$(TMPTOP)
	$(create_md5sum)     $(TMPTOP)
	chown -R root:root   $(TMPTOP)
	chmod -R u+w,go=rX   $(TMPTOP)
	dpkg --build	     $(TMPTOP) ..
	@test -d debian/stamp/binary || mkdir -p debian/stamp/binary
	@echo done > $@

debian/stamp/binary/python-semanage:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	$(make_directory)    $(TMPTOP)/DEBIAN
	$(install_script)    debian/python_prerm             $(TMPTOP)/DEBIAN/prerm
	$(install_script)    debian/python_postinst          $(TMPTOP)/DEBIAN/postinst
	$(get-shlib-deps)
	if dpkg --compare-versions $(MIN_PY_VERSIONS) le $(PYDEFAULT); then              \
          echo 'python:Depends=python (>= $(MIN_PY_VERSIONS)), python (<< $(STOP_VERSION))'  >>  debian/substvars;     \
        else                                                                             \
          echo 'python:Depends=python (>= $(MIN_PY_VERSIONS)) | python$(MIN_PY_VERSIONS), python (<< $(STOP_VERSION))'\
                                                                  >>  debian/substvars;   \
        fi
	echo 'python:Provides=$(PY_PROVIDES)'                 >> debian/substvars
	dpkg-gencontrol	     -p$(package) -isp	     -P$(TMPTOP)
	$(create_md5sum)     $(TMPTOP)
	chown -R root:root   $(TMPTOP)
	chmod -R u+w,go=rX   $(TMPTOP)
	dpkg --build	     $(TMPTOP) ..
	@test -d debian/stamp/binary || mkdir -p debian/stamp/binary
	@echo done > $@

debian/stamp/binary/libsemanage1-dev:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	$(make_directory)    $(TMPTOP)/DEBIAN
	dpkg-gencontrol	     -p$(package) -isp	     -P$(TMPTOP)
	$(create_md5sum)     $(TMPTOP)
	chown -R root:root   $(TMPTOP)
	chmod -R u+w,go=rX   $(TMPTOP)
	dpkg --build	     $(TMPTOP) ..
	@test -d debian/stamp/binary || mkdir -p debian/stamp/binary
	@echo done > $@

debian/stamp/binary/libsemanage-ruby1.8:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	$(make_directory)    $(TMPTOP)/DEBIAN
	$(get-shlib-deps)
	dpkg-gencontrol	     -p$(package) -isp	     -P$(TMPTOP)
	find $(TMPTOP) -type f -name \*.so -exec chmod 0644 {} \;
	$(create_md5sum)     $(TMPTOP)
	chown -R root:root   $(TMPTOP)
	chmod -R u+w,go=rX   $(TMPTOP)
	dpkg --build	     $(TMPTOP) ..
	@test -d debian/stamp/binary || mkdir -p debian/stamp/binary
	@echo done > $@
