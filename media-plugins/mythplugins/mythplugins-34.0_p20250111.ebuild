# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISABLE_AUTOFORMATTING="yes"
PYTHON_COMPAT=( python3_{10..12} )

inherit edo flag-o-matic java-pkg-opt-2 python-single-r1
inherit qmake-utils readme.gentoo-r1 systemd toolchain-funcs user-info

DESCRIPTION="Official MythTV plugins"
HOMEPAGE="https://www.mythtv.org https://github.com/MythTV/mythtv"
if [[ ${PV} == *_p* ]] ; then
	MY_COMMIT="ac34c663b23b3dddb6c0ce3f81a1cd93b801d2e7"
	SRC_URI="https://github.com/MythTV/mythtv/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
	# mythtv and mythplugins are separate builds in the github MythTV project
	S="${WORKDIR}/mythtv-${MY_COMMIT}/mythplugins"
else
	SRC_URI="https://github.com/MythTV/mythtv/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	# mythtv and mythplugins are separate builds in the github mythtv project
	S="${WORKDIR}/${P}/mythplugins"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

MYTHPLUGINS="mytharchive mythgame mythmusic mythnetvision \
mythnews mythweather mythzmserver mythzoneminder"
IUSE="${MYTHPLUGINS} alsa cdda cdr exif flac +hls ieee1394 libass musicbrainz +opengl raw +theora +vorbis +xml xvid"

# Mythnetvision temporarily disabled by upstream - should be fixed soon.
REQUIRED_USE="
	!mythnetvision
	mytharchive? ( ${PYTHON_REQUIRED_USE} )
	mythnetvision? ( ${PYTHON_REQUIRED_USE} )
"
RDEPEND="
	dev-libs/glib:2
	dev-libs/openssl:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
	media-libs/freetype:2
	media-libs/libpng:=
	virtual/libudev:=
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXv
	x11-libs/libXxf86vm
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac )
	hls? (
		media-libs/faac
		media-libs/libvpx:=
		media-libs/x264:=
		media-sound/lame
	)
	ieee1394? (
		media-libs/libiec61883
		sys-libs/libavc1394
		sys-libs/libraw1394
	)
	libass? ( media-libs/libass:= )
	musicbrainz? ( media-libs/musicbrainz )
	=media-tv/mythtv-${PV}*[alsa?,cdda?,cdr?,ieee1394?,libass?,opengl?,raw?,xml?,xvid]
	mytharchive? (
		${PYTHON_DEPS}
		app-cdr/dvd+rw-tools
		dev-python/pillow
		dev-python/mysqlclient
		=media-tv/mythtv-${PV}*[python]
		media-video/dvdauthor
		media-video/mjpegtools[png]
		app-cdr/cdrtools
	)
	mythgame? (
		sys-libs/zlib[minizip]
		dev-perl/XML-Twig
	)
	mythmusic? (
		media-libs/flac
		media-libs/libvorbis
	)
	mythnetvision? (
		${PYTHON_DEPS}
		dev-python/lxml
		dev-python/pycurl
		dev-python/urllib3
		=media-tv/mythtv-${PV}*[python]
	)
	mythweather? (
		dev-perl/Date-Manip
		dev-perl/XML-Simple
		dev-perl/XML-XPath
		dev-perl/DateTime
		dev-perl/Image-Size
		dev-perl/DateTime-Format-ISO8601
		dev-perl/SOAP-Lite
		dev-perl/JSON
		=media-tv/mythtv-${PV}*[perl]
	)
	mythzmserver? ( dev-db/mysql-connector-c:= )
	vorbis? ( media-libs/libvorbis )
	theora? ( media-libs/libtheora )
	xml? ( dev-libs/libxml2:= )
	xvid? ( media-libs/xvid )
"
DEPEND=${RDEPEND}

DOC_CONTENTS="
Mythgallery code moved to mythtv and is no longer a plugin in version 31.0.
As of 3/23/2020, MythNetVision is disabled, work in progress.

No plugins are installed by default. Enable plugins individually with USE flags:
mytharchive mythgame mythmusic mythnetvision mythweather mythzmserver mythzoneminder
"

src_configure() {
	econf \
		--python=${EPYTHON} \
		--extra-ldflags="${LDFLAGS}" \
		--disable-mythbrowser \
		$(use_enable cdda cdio) \
		$(use_enable exif) \
		$(use_enable exif new-exif) \
		$(use_enable musicbrainz) \
		$(use_enable opengl) \
		$(use_enable raw dcraw) \
		$(use_enable mytharchive) \
		$(use_enable mythgame) \
		$(use_enable mythnetvision) \
		$(use_enable mythnews) \
		$(use_enable mythweather) \
		$(use_enable mythzmserver) \
		$(use_enable mythzoneminder)
}

src_install() {
	emake STRIP="true" INSTALL_ROOT="${D}" install
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
