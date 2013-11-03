#
# Makefile for lunar-dev-tools - a collection of lunar-related development tools
#

PROJECT=lunar-dev-tools
# versioning scheme: since this is mostly a linear process if incremental
# but we do not update that often we use year.number as version number
# i.e. 2004.9 2004.10 2004.11 ...
VERSION = 2013.1

bin_PROGS = prog/lsubmit
DOCS = README COPYING
MANPAGES = $(wildcard man/*)

all:

.PHONY: install dist
install:
	install -d $(DESTDIR)/usr/bin
	for PROGRAM in ${bin_PROGS} ; do \
	    install -m755 $${PROGRAM} $(DESTDIR)/usr/bin/ ; \
	done
	for MANPAGE in ${MANPAGES} ; do \
	    EXT=`echo "$${MANPAGE:(($${#MANPAGE}-1)):1}"` ; \
	    install -d $(DESTDIR)/usr/share/man/man$$EXT ; \
	    install -m644 $${MANPAGE} $(DESTDIR)/usr/share/man/man$$EXT/ ; \
	done
	install -d $(DESTDIR)/usr/share/doc/$(PROJECT)
	for DOC in ${DOCS} ; do \
		install -m644 $${DOC} $(DESTDIR)/usr/share/doc/$(PROJECT)/ ; \
	done

dist:
	git archive --format=tar --prefix=$(PROJECT)-$(VERSION)/ $(PROJECT)-$(VERSION) | bzip2 > $(PROJECT)-$(VERSION).tar.bz2
