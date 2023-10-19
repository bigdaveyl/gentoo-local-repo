# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( pypy3 python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Wrapper script for OpenConnect supporting AD/Cisco SSL-VPNs"
HOMEPAGE="https://github.com/vlaci/openconnect-sso/"
SRC_URI="https://github.com/vlaci/openconnect-sso/archive/v0.8.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

RDEPEND=""
DEPEND="
	dev-python/black
	dev-python/certifi
	dev-python/cffi
	dev-python/charset-normalizer
	dev-python/click
	dev-python/coverage
	dev-python/cryptography
	dev-python/exceptiongroup
	dev-python/idna
	dev-python/importlib-metadata
	dev-python/iniconfig
	dev-python/jaraco-classes
	dev-python/jeepney
	dev-python/keyring
	dev-python/lxml
	dev-python/markupsafe
	dev-python/more-itertools
	dev-python/mypy_extensions
	dev-python/packaging
	dev-python/pathspec
	dev-python/platformdirs
	dev-python/pluggy
	dev-python/prompt-toolkit
	dev-python/pycparser
	dev-python/pyotp
	dev-python/pyparsing
	dev-python/PyQt5
	dev-python/PyQt5-sip
	dev-python/PyQtWebEngine
	dev-python/PySocks
	dev-python/pyxdg
	dev-python/requests
	dev-python/structlog
	dev-python/secretstorage
	dev-python/toml
	dev-python/tomli
	dev-python/typing-extensions
	dev-python/urllib3
	dev-python/wcwidth
	dev-python/werkzeug
	dev-python/zipp
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	test? (
		dev-python/pytest
		dev-python/pytest-asyncio
		dev-python/pytest-cov
		dev-python/pytest-httpserver
	)
"

distutils_enable_tests pytest
