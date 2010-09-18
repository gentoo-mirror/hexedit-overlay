# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

EAPI=2

DESCRIPTION="Official HTTP(S) GUI interface for the Asterisk soft PBX"
HOMEPAGE="http://www.asterisk.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=net-misc/asterisk-1.2
"

ESVN_REPO_URI="http://svn.digium.com/svn/asterisk-gui/branches/2.0"
ESVN_PROJECT="asterisk-gui"

src_configure() {
	econf\
		--libdir=/usr/$(get_libdir)\
		--sysconfdir=/etc\
		--localstatedir=/var\
	|| die "configure failed."
}

src_compile() {
	emake || die "make failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed."

	#fixing permissions
	if [ -n $(egetent passwd asterisk) ]; then
		einfo "Fixing permissions..."
		chown -R asterisk.asterisk ${D}etc/asterisk ${D}var/lib/asterisk
		chmod -R u=rwX,g=rX,o= ${D}etc/asterisk ${D}var/lib/asterisk
	fi
}
