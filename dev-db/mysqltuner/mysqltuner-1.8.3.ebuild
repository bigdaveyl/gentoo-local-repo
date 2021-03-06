# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=MySQLTuner-perl

DESCRIPTION="MySQLTuner is a high-performance MySQL tuning script"
HOMEPAGE="https://github.com/major/MySQLTuner-perl"

LICENSE="GPL-3+"
SLOT="0"

if [[ ${PV} =~ "9999" ]]; then
	EGIT_REPO_URI="https://github.com/major/MySQLTuner-perl.git"
	EGIT_BRANCH="master"
	inherit git-r3
else
	SRC_URI="https://github.com/major/MySQLTuner-perl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

RDEPEND="dev-lang/perl
	virtual/perl-Getopt-Long"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=( USAGE.md CONTRIBUTING.md INTERNALS.md basic_passwords.txt vulnerabilities.csv )

src_install() {
	einstalldocs

	newbin "${PN}.pl" "${PN}"

	# Passwords and vulnerabilities are meant to be fed
	# to the script uncompressed.
	docompress -x "/usr/share/doc/${PF}/basic_passwords.txt" "/usr/share/doc/${PF}/vulnerabilities.csv"
}
