# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="SiliconDust HDHomeRun Utilties"
HOMEPAGE="https://www.silicondust.com/support/linux/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/Silicondust/libhdhomerun.git"
	inherit git-r3
	S="${WORKDIR}/${PN}-${PV}"
else
	SRC_URI="https://download.silicondust.com/hdhomerun/${PN}_${PV}.tgz"
	KEYWORDS="amd64 arm64 x86"
	S="${WORKDIR}/${PN}"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

PATCHES=(
	"${FILESDIR}/20190621-use_shared_library.patch"
)


src_prepare() {
	default
	# Remove forced optimization from Makefile
	sed -i 's:-O2::' Makefile || die "Was the Makefile changed?"
}

src_compile() {
	emake CC="$(tc-getCC)" STRIP=:
}

src_install() {
	dobin hdhomerun_config
	dolib.so libhdhomerun.so

	insinto /usr/include/hdhomerun
	doins *.h
}
