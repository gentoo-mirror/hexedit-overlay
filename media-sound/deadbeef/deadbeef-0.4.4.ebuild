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
IUSE="nls threads rpath nullout alsa oss pulse gtk +curl lastfm +albumart
+supereq sid mad ape vtx adplug +hotkeys vorbis ffmpeg flac sndfile wavpack cdda gme
dumb +notify +shellexec musepack wildmidi tta dts aac mms shn ao"

DEPEND="
	media-libs/libsamplerate
	nls? ( dev-util/intltool )
	threads? ( dev-libs/pth )
	gtk? ( >=x11-libs/gtk+-2.12 )
	alsa? ( media-libs/alsa-lib )
	pulse? ( media-sound/pulseaudio )
	notify? ( sys-apps/dbus )
	curl? ( net-misc/curl )
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
		$(use_enable rpath)\
		$(use_enable nullout)\
		$(use_enable alsa)\
		$(use_enable oss)\
		$(use_enable pulse)\
		$(use_enable gtk gtkui)\
		$(use_enable curl vfs-curl)\
		$(use_enable lastfm lfm)\
		$(use_enable albumart artwork)\
		$(use_enable supereq)\
		$(use_enable sid)\
		$(use_enable mad)\
		$(use_enable ape ffap)\
		$(use_enable vtx)\
		$(use_enable adplug)\
		$(use_enable hotkeys)\
		$(use_enable vorbis)\
		$(use_enable ffmpeg)\
		$(use_enable flac)\
		$(use_enable sndfile)\
		$(use_enable wavpack)\
		$(use_enable cdda)\
		$(use_enable gme)\
		$(use_enable dumb)\
		$(use_enable notify)\
		$(use_enable shellexec)\
		$(use_enable musepack)\
		$(use_enable wildmidi)\
		$(use_enable tta)\
		$(use_enable dts dca)\
		$(use_enable aac)\
		$(use_enable mms)\
		$(use_enable shn)\
		$(use_enable ao)\
	|| die "configure failed."
}

src_compile() {
	emake || die "make failed."
} 

src_install() {
	emake DESTDIR="${D}" install || die "install failed."
}
