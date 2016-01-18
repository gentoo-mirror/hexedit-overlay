# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit webapp eutils confutils depend.php

DESCRIPTION="A friendly web-based DNS administration tool for PowerDNS"
HOMEPAGE="http://www.poweradmin.org"
SRC_URI="http://sourceforge.net/projects/poweradmin/files/poweradmin-${PV}.tgz"

LICENSE="GPL-3"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="mysql postgres vhosts"

DEPEND=""
RDEPEND="dev-lang/php[session,postgres?,crypt]
	mysql? ( || ( dev-php/PEAR-MDB2[mysql] dev-php/PEAR-MDB2[mysqli] ) )
	mysql? ( || ( dev-lang/php[mysql] dev-lang/php[mysqli] ) )
	postgres? ( dev-php/PEAR-MDB2[postgres] )
	sys-devel/gettext"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
	confutils_require_any mysql postgres
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
}
