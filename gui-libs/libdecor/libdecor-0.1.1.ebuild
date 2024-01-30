# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson-multilib

DESCRIPTION="A client-side decorations library for Wayland client"
HOMEPAGE="https://gitlab.freedesktop.org/libdecor/libdecor"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/-/archive/${PV}/${P}.tar.gz"
    KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+dbus"

DEPEND="
	>=dev-libs/wayland-1.18[${MULTILIB_USEDEP}]
	>=dev-libs/wayland-protocols-1.15
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	x11-libs/pango[${MULTILIB_USEDEP}]
	x11-libs/cairo[${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-build/meson-0.47"
