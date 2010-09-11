# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="SCCP channel plugin for the Asterisk soft PBX"
HOMEPAGE="http://chan-sccp-b.sourceforge.net"
SRC_URI="http://freefr.dl.sourceforge.net/project/chan-sccp-b/V3/Chan_SCCP-3.0_RC1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE="+pickup +park +dirtrfr +monitor conference +manager +functions indications
+realtime feature-monitor advanced-functions dynamic-speeddial debug static"

DEPEND=">=net-misc/asterisk-1.2"

src_unpack() {
	die "${P} == ${PV}"
}

src_configure() {
	die ""
}

src_compile() {
	die ""
}

src_install() {
	die ""
}

pkg_postinst() {
	die ""
}
