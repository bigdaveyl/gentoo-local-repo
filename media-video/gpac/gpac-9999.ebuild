# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == *9999 ]] ; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/gpac/gpac"
else
	SRC_URI="https://github.com/gpac/gpac/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
fi

inherit toolchain-funcs ${SCM} xdg

DESCRIPTION="Implementation of the MPEG-4 Systems standard developed from scratch in ANSI C"
HOMEPAGE="https://gpac.wp.imt.fr/"

LICENSE="GPL-2"
# subslot == libgpac major
SLOT="0/11"
IUSE="a52 aac alsa cpu_flags_x86_sse2 debug dvb ffmpeg hidapi http2 ipv6 jack jpeg jpeg2k lzma mad ogg opengl oss png
	pulseaudio ssl static-libs svg theora truetype vorbis xml xvid X zlib"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	media-libs/libsdl
	a52? ( media-libs/a52dec )
	aac? ( media-libs/faad2 )
	alsa? ( media-libs/alsa-lib )
	ffmpeg? ( media-video/ffmpeg:0= )
	hidapi? ( dev-libs/hidapi )
	http2? ( net-libs/nghttp2 )
	jack? ( virtual/jack )
	jpeg? ( media-libs/libjpeg-turbo:0= )
	jpeg2k? ( media-libs/openjpeg:2 )
	lzma? ( app-arch/lzma )
	mad? ( media-libs/libmad )
	ogg? ( media-libs/libogg )
	opengl? (
		media-libs/freeglut
		virtual/glu
		virtual/opengl
	)
	png? ( media-libs/libpng:0= )
	pulseaudio? ( media-sound/pulseaudio )
	theora? ( media-libs/libtheora )
	truetype? ( media-libs/freetype:2 )
	ssl? (
		dev-libs/openssl:0=
	)
	vorbis? ( media-libs/libvorbis )
	X? (
		x11-libs/libXt
		x11-libs/libX11
		x11-libs/libXv
		x11-libs/libXext
	)
	xml? ( dev-libs/libxml2:2= )
	xvid? ( media-libs/xvid )
	zlib? ( sys-libs/zlib )
"
DEPEND="
	${RDEPEND}
	dvb? ( sys-kernel/linux-headers )
"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.0-zlib-compile.patch"
)

DOCS=(
	share/doc/CODING_STYLE
	share/doc/GPAC\ UPnP.doc
	share/doc/ISO\ 639-2\ codes.txt
	share/doc/SceneGenerators
	share/doc/ipmpx_syntax.bt
	Changelog
	README.md
)

#HTML_DOCS="share/doc/*.html"

my_use() {
	local flag="$1" pflag="${2:-$1}"
	if use ${flag}; then
		echo "--use-${pflag}=system"
	else
		echo "--use-${pflag}=no"
	fi
}

src_prepare() {
	default
	sed -i -e "s:\(--disable-.*\)=\*):\1):" configure || die
}

# Extra libraries used are: opensvc openhevc platinum freenect directfb tinygl vtb

src_configure() {
	tc-export CC CXX AR RANLIB

	local myeconfargs=(
		--cc="$(tc-getCC)"
		--cxx="$(tc-getCXX)"
		--libdir="$(get_libdir)"
		--verbose
		--enable-pic
		--disable-qjs
		$(usex debug '--enable-debug' '')
		$(usex ipv6 '' '--disable-ipv6')
		$(usex static-libs '--static-build' '')
		$(usex static-libs '--static-modules' '')
		$(usex X '' '--disable-x11')
		$(usex X '' '--disable-x11-shm')
		$(usex X '' '--disable-x11-xv')
		$(usex X "--X11-path=${EPREFIX}/usr/$(get_libdir)" '')
		$(use_enable dvb dvbx)
		$(use_enable opengl 3d)
		$(use_enable svg)
		$(my_use a52)
		$(my_use alsa)
		$(my_use aac faad)
		$(my_use dvb dvb4linux)
		$(my_use ffmpeg)
		$(my_use jack)
		$(my_use jack)
		$(my_use jpeg)
		$(my_use jpeg2k openjpeg)
		$(my_use hidapi hid)
		$(my_use http2 nghttp2)
		$(my_use lzma)
		$(my_use mad)
		$(my_use ogg)
		$(my_use oss)
		$(my_use png)
		$(my_use pulseaudio)
		$(my_use ssl)
		$(my_use theora)
		$(my_use truetype freetype)
		$(my_use vorbis)
		$(my_use xvid)
		$(my_use zlib)
	)

	if use amd64 || use x86 ; then
		# Don't pass -mno-sse2 on non amd64/x86
		myeconfargs+=(
			--extra-cflags="${CFLAGS} $(usex cpu_flags_x86_sse2 '-msse2' '-mno-sse2')"
		)
	else
		myeconfargs+=(
			--extra-cflags="${CFLAGS}"
		)
	fi

	econf "${myeconfargs[@]}"
}

src_install() {
	einstalldocs
	emake STRIP="true" DESTDIR="${ED}" install
	emake STRIP="true" DESTDIR="${ED}" install-lib
}
