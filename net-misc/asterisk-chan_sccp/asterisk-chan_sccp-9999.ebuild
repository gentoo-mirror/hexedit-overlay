# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit subversion

DESCRIPTION="SCCP channel plugin for the Asterisk soft PBX"
HOMEPAGE="http://chan-sccp-b.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+pickup +park +dirtrfr +monitor conference +manager +functions indications +realtime video advanced-functions dynamic-config dynamic-speeddial debug static"

ESVN_REPO_URI="https://chan-sccp-b.svn.sourceforge.net/svnroot/chan-sccp-b/trunk"
ESVN_PROJECT="asterisk-chan_sccp"

DEPEND="
	>=net-misc/asterisk-1.2
	>=sys-devel/autoconf-2.6.0
	>=sys-devel/automake-1.10
	>=sys-devel/libtool-2.2.2
	>=sys-devel/m4-1.4.5
"

src_configure() {
	econf\
		$(use_enable debug)\
		$(use_enable static)\
		$(use_with pickup)\
		$(use_with park)\
		$(use_with dirtrfr)\
		$(use_with monitor)\
		$(use_with conference)\
		$(use_with manager)\
		$(use_with functions)\
		$(use_with indications)\
		$(use_with realtime)\
		$(use_with video)\
		$(use_with advanced-config)\
		$(use_with advanced-functions)\
		$(use_with dynamic-speeddial)\
	|| die "configure failed."
}

src_compile() {
	emake || die "make failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed."

	# install configs
	einfo "Installing default config files..."
	mkdir -p ${D}etc/asterisk
	find ${S}/conf/ -name '.svn' -print0 | xargs -0 rm -rf # cleaning svn files
	cp -rf ${S}/conf/* ${D}etc/asterisk

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
