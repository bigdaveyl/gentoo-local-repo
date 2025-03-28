# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit meson python-single-r1

DESCRIPTION="A complex camera support library for Linux, Android, and ChromeOS"
HOMEPAGE="https://libcamera.org/"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.libcamera.org/libcamera/libcamera.git"
else
	SRC_URI="https://github.com/${PN}-org/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

IUSE="debug drm gnutls gstreamer jpeg libevent qt6 sdl tiff trace udev unwind v4l2"
REQUIRED_USE="qt6? ( tiff ) ${PYTHON_REQUIRED_USE}"

DEPEND="
	dev-lang/python
	dev-libs/libyaml:=
	dev-python/jinja2
	dev-python/ply
	dev-python/pyyaml
	|| (
		net-libs/gnutls
		dev-libs/openssl
	)
	debug? ( dev-libs/elfutils:= )
	gstreamer? ( media-libs/gstreamer:= )
	libevent?
	(
		dev-libs/libevent:=
		drm? ( x11-libs/libdrm:= )
		jpeg? ( media-libs/libjpeg-turbo:= )
		sdl? ( media-libs/libsdl2:= )
	)
	media-libs/libepoxy
	qt6?
	(
		dev-qt/qtbase:6[gui]
		dev-qt/qttools:6
	)
	tiff? ( media-libs/tiff:= )
	trace? ( dev-util/lttng-ust:= )
	udev? ( virtual/libudev:= )
	unwind? ( sys-libs/libunwind:= )
	v4l2? ( media-libs/libv4l )
"
RDEPEND="
	${DEPEND}
	trace? ( dev-util/lttng-tools )
	${PYTHON_DEPS}
"

BDEPEND="
	virtual/pkgconfig
	${PYTHON_DEPS}
"

src_configure() {
	local emesonargs=(
		-Ddocumentation=disabled
		$(meson_feature libevent cam)
		$(meson_feature gstreamer)
		$(meson_feature qt6 qcam)
		$(meson_feature trace tracing)
		$(meson_use v4l2)
	)

	meson_src_configure "-Dpipelines=uvcvideo,ipu3"
}
