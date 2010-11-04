# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Ultimate Music Player For GNU/Linux"
HOMEPAGE="http://deadbeef.sourceforge.net/"
SRC_URI="http://sourceforge.net/projects/deadbeef/files/deadbeef-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="nls threads gtk alsa oss pulse notify +shellexec +vfs-curl lastfm +albumart +supereq mad ape vorbis
ffmpeg flac sndfile wavpack cdda aac mms ao"

DEPEND="
	media-libs/libsamplerate
	nls? ( dev-util/intltool )
	gtk? ( >=x11-libs/gtk+-2.12 )
	alsa? ( media-libs/alsa-lib )
	pulse? ( media-sound/pulseaudio )
	notify? ( sys-apps/dbus )
	vfs-curl? ( net-misc/curl )
	lastfm? ( >=net-misc/curl-7.10 )
	mad? ( media-libs/libmad )
	vorbis? (
		media-libs/libvorbis
		media-libs/libogg
	)
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac )
	sndfile? ( media-libs/libsndfile )
	wavpack? ( media-sound/wavpack )
	aac? ( media-libs/faad2 )
	cdda? (
		dev-libs/libcdio
		media-libs/libcddb
	)
	ao? ( sys-libs/zlib )
"
RDEPEND="${DEPEND}"

src_configure() {
	econf\
		$(use_enable nls)\
		$(use_enable threads threads pth)\
		$(use_enable gtk gtkui)\
		$(use_enable alsa)\
		$(use_enable oss)\
		$(use_enable pulse)\
		$(use_enable notify)\
		$(use_enable shellexec)\
		$(use_enable vfs-curl)\
		$(use_enable lastfm lfm)\
		$(use_enable albumart artwork)\
		$(use_enable supereq)\
		$(use_enable mad)\
		$(use_enable ape ffap)\
		$(use_enable vorbis)\
		$(use_enable ffmpeg)\
		$(use_enable flac)\
		$(use_enable sndfile)\
		$(use_enable wavpack)\
		$(use_enable cdda)\
		$(use_enable aac)\
		$(use_enable mms)\
		$(use_enable ao)\
	|| die "configure failed."
}

src_compile() {
	emake || die "make failed."
} 

src_install() {
	emake DESTDIR="${D}" install || die "install failed."
}
