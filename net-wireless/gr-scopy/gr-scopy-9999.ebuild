# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )

inherit cmake python-single-r1

DESCRIPTION="Scopy IIO blocks for GNU Radio"
HOMEPAGE="https://github.com/analogdevicesinc/gr-scopy"
if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/analogdevicesinc/gr-scopy.git"
	inherit git-r3
else
	COMMIT="ee184f7633e79e27a8f7c55e56c35c294717137b"
	SRC_URI="https://github.com/analogdevicesinc/gr-scopy/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-3+"
SLOT="0"
REQUIRED_USE=${PYTHON_REQUIRED_USE}

RDEPEND="${PYTHON_DEPS}
	=net-wireless/gnuradio-3.10*:=
	sci-libs/volk:=
	dev-libs/log4cpp:=
	"
DEPEND="${RDEPEND}"

src_install() {
	cmake_src_install
	python_optimize
}
