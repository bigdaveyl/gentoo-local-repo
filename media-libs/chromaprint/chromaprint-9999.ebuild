# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib


if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/acoustid/chromaprint.git"
	inherit git-r3
else
	DESCRIPTION="Library implementing a custom algorithm for extracting audio fingerprints"
	HOMEPAGE="https://acoustid.org/chromaprint"
	SRC_URI="https://github.com/acoustid/${PN}/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~mips ppc ppc64 ~riscv sparc x86"
fi

LICENSE="LGPL-2.1"
SLOT="0/1"
IUSE="tools"

RDEPEND="tools? ( >=media-video/ffmpeg-5:=[${MULTILIB_USEDEP}] )
	!tools? ( sci-libs/fftw:=[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

DOCS=( NEWS.txt README.md )

multilib_src_configure() {

	local mycmakeargs=(
		-DBUILD_TESTS=off

		-DBUILD_TOOLS=$(multilib_native_usex tools)
		-DFFT_LIB=$(usex tools 'avfft' 'fftw3')
		$(multilib_native_usex tools '-DAUDIO_PROCESSOR_LIB=swresample' '')
		# Automagicallyish looks for ffmpeg, but there's no point
		# even doing the check unless we're building with tools
		# (=> without fftw3, and with ffmpeg).
		-DCMAKE_DISABLE_FIND_PACKAGE_FFmpeg=$(multilib_native_usex !tools)
	)

	cmake_src_configure
}
