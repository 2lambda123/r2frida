include ./CONFIG
DEPENDS=
SUDO?=sudo
PACKAGE_DIR?=${PWD}

all: root
	$(SUDO) rm -rf control data
	${MAKE} clean
	mkdir -p data
	cp -rf root/* data
	${MAKE} control
	${MAKE} deb

rootnobuild:
	cd ../.. ; $(MAKE) install \
		R2_PLUGDIR=/private/var/radare2/lib/radare2/last \
		DESTDIR=$(shell pwd)/root
root:
	cd ../.. ; $(MAKE) ios && $(MAKE) install \
		R2_PLUGDIR=/private/var/radare2/lib/radare2/last \
		DESTDIR=$(shell pwd)/root

include deb.mk
