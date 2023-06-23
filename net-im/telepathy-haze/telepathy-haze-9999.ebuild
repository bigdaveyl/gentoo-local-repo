# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-any-r1 autotools

DESCRIPTION="Telepathy connection manager providing libpurple supported protocols"
HOMEPAGE="https://telepathy.freedesktop.org https://developer.pidgin.im/wiki/TelepathyHaze"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/TelepathyIM/telepathy-haze.git"
	inherit git-r3
else
	SRC_URI="https://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	net-im/pidgin[dbus]
	net-libs/telepathy-glib
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-libs/libxslt
	dev-util/glib-utils
	virtual/pkgconfig
	test? (
		dev-python/pygobject:3
		$(python_gen_any_dep 'dev-python/twisted[${PYTHON_USEDEP}]')
	)
"
RESTRICT="!test? ( test )"

python_check_deps() {
	if use test ; then
		has_version "dev-python/twisted[${PYTHON_USEDEP}]"
	fi
}

src_prepare() {
	default

	einfo "Regenerating autotools files..."
	eautoreconf
}
