# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_sccp/asterisk-chan_sccp-0.0.20060204.ebuild,v 1.2 2007/01/06 16:46:23 drizzt Exp $

inherit eutils

EAPI="2"

IUSE="+park +pickup +dirtrfr conference +realtime direct-rtp +manager indications debug"

MY_PV="${PV/2.0./}"
MY_P="chan_sccp-b_${MY_PV}"

DESCRIPTION="SCCP channel plugin for the Asterisk soft PBX"
HOMEPAGE="http://chan-sccp-b.sourceforge.net"
SRC_URI="http://freefr.dl.sourceforge.net/project/chan-sccp-b/V2/Chan_SCCP-2.0_Final.tar.gz"

S="${WORKDIR}/${MY_P}/"

SLOT="0"
KEYWORDS="ppc x86 amd64"
LICENSE="GPL-2"

DEPEND=">=net-misc/asterisk-1.0.5-r2"

fix_yn() {
	use $1 && key=y || key=n
	sed -i -e "s:.*$2.*y\/n.*:key=${key}:" create_config.sh
}

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch "${FILESDIR}/${MY_P}-ifdef.patch"
	if ! use debug; then
		sed -i -e "s:^\(DEBUG=.*\):#\1:" Makefile
	fi
	sed -i "/read key/ d" create_config.sh

	fix_yn park PARK
	fix_yn pickup PICKUP
	fix_yn dirtrfr DIRTRFR
	fix_yn conference CONFERENCE
	fix_yn realtime realtime
	fix_yn direct-rtp "Direct RTP"
	fix_yn manager "manager events"
	fix_yn indications "Debug SCCP indications"
}

src_compile() {
	emake -j1 || die
}

src_install() {
	mkdir -p ${D}/usr/lib/asterisk/modules
	emake INSTALL_PREFIX=${D} install || die

	dodoc conf/* contrib/*

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		einfo "Fixing permissions..."
		chown -R asterisk:asterisk ${D}etc/asterisk
		chmod -R u=rwX,g=rX,o= ${D}etc/asterisk
	fi
}

pkg_postinst() {
	ewarn "You have to disable asterisk's chan_skinny to use this module!"
	elog "Add \"noload => chan_skinny.so\" to ${ROOT}etc/asterisk/modules.conf"
}
