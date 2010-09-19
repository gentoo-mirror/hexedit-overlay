# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

EAPI=2

DESCRIPTION="An official HTTP(S) GUI interface for the Asterisk soft PBX"
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

pkg_postinst() {
	elog "To enable asterisk-gui edit you configuration files:"
	elog "--- manager.conf ---"
	elog "  enabled = yes"
	elog "  webenabled = yes"
	elog "--- http.conf ---"
	elog "  enabled = yes"
	elog "  enablestatic = yes"
	elog "  redirect = / /static/config/cfgbasic.html"
	elog "and create appropriate entry in manager.conf for the administrative user"
	ewarn "PLEASE READ THE security.txt FILE!"
	elog "  [admin]"
	elog "  secret = thiswouldbeaninsecurepassword"
	elog "  read = system,call,log,verbose,command,agent,config"
	elog "  write = system,call,log,verbose,command,agent,config"
}
