#!/bin/sh
if [ -f ../config.mk ]; then
	. ../config.mk
fi
[ -z "${VERSION}" ] && VERSION=3.9.0
if [ "${GRAB_R2}" = 1 ]; then
(
	RV=${VERSION}
	RA=amd64
	echo "[*] Downloading r2-${RV}-${RA}"
	wget -c http://radare.mikelloc.com/get/${RV}/radare2_${RV}_${RA}.deb
	wget -c http://radare.mikelloc.com/get/${RV}/radare2-dev_${RV}_${RA}.deb
	#sudo apt update -y
	#sudo apt upgrade -y
	sudo apt install -y libssl-dev # why
	echo "[*] Installing r2-${RV}-${RA}"
	sudo dpkg -i radare2_${RV}_${RA}.deb
	sudo dpkg -i radare2-dev_${RV}_${RA}.deb
)
fi

# install NodeJS LTS
(
	NV=v12.16.1
	NA=linux-x64
	echo "[*] Downloading NodeJS"
	cd /work
	wget -c https://nodejs.org/dist/${NV}/node-${NV}-${NA}.tar.xz
	echo "[*] Installing NodeJS"
	tar xJf node-${NV}-${NA}.tar.xz -C /tmp
	export PATH="/tmp/node-${NV}-${NA}/bin:$PATH"
	ls /tmp
	node --version || exit 1
	npm --version || exit 1
)
export PATH="/tmp/node-${NV}-${NA}/bin:$PATH"
[ -z "${DESTDIR}" ] && DESTDIR=/
[ -z "${R2_LIBR_PLUGINS}" ] && R2_LIBR_PLUGINS=/usr/lib/radare2/last
make R2_PLUGDIR=${R2_LIBR_PLUGINS} DESTDIR=${DESTDIR}
