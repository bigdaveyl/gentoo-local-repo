# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..11} )

inherit cmake python-single-r1

DESCRIPTION="A C++ library for interfacing with the ADALM2000"
HOMEPAGE="https://github.com/analogdevicesinc/gr-m2k"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/analogdevicesinc/gr-m2k.git"
else
	COMMIT="f98dfa42134d2dff458c7832842d1f51c3131aa4"
	SRC_URI="https://github.com/analogdevicesinc/gr-m2k/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~arm ~riscv ~x86"
fi

LICENSE="GPL-3+"
SLOT="0/${PV}"
IUSE="doc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="=net-wireless/gnuradio-3.10*:0=[${PYTHON_SINGLE_USEDEP}]
	dev-libs/boost:=
	net-libs/libiio
	net-wireless/libm2k
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_BUILD_RPATH=TRUE
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	find  "${D}" -name '__init__.py[co]' -delete || die
	python_optimize
	mv "${ED}/usr/share/doc/gr-m2k" "${ED}/usr/share/doc/${P}"
}
