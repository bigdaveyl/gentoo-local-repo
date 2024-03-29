# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

CRATES="
	aho-corasick-0.7.18
	anyhow-1.0.57
	assert_cmd-2.0.4
	assert_fs-1.0.7
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bitvec-1.0.0
	bitvec_helpers-1.0.2
	bstr-0.2.17
	byteorder-1.4.3
	cc-1.0.73
	cfg-if-1.0.0
	clap-3.1.18
	clap_derive-3.1.18
	clap_lex-0.2.0
	console-0.15.0
	crc-3.0.0
	crc-catalog-2.1.0
	crossbeam-utils-0.8.8
	difflib-0.4.0
	doc-comment-0.3.3
	either-1.6.1
	encode_unicode-0.3.6
	enum-iterator-0.7.0
	enum-iterator-derive-0.7.0
	fastrand-1.7.0
	float-cmp-0.9.0
	fnv-1.0.7
	form_urlencoded-1.0.1
	funty-2.0.0
	getset-0.1.2
	git2-0.14.4
	globset-0.4.9
	globwalk-0.8.1
	hashbrown-0.11.2
	heck-0.4.0
	hermit-abi-0.1.19
	hevc_parser-0.4.6
	idna-0.2.3
	ignore-0.4.18
	indexmap-1.8.2
	indicatif-0.16.2
	instant-0.1.12
	itertools-0.10.3
	itoa-1.0.2
	jobserver-0.1.24
	lazy_static-1.4.0
	libc-0.2.126
	libgit2-sys-0.13.4+1.4.2
	libz-sys-1.1.8
	log-0.4.17
	matches-0.1.9
	memchr-2.5.0
	minimal-lexical-0.2.1
	nom-7.1.1
	normalize-line-endings-0.3.0
	num-traits-0.2.15
	num_threads-0.1.6
	number_prefix-0.4.0
	once_cell-1.12.0
	os_str_bytes-6.1.0
	percent-encoding-2.1.0
	pkg-config-0.3.25
	predicates-2.1.1
	predicates-core-1.0.3
	predicates-tree-1.0.5
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.39
	quote-1.0.18
	radium-0.7.0
	redox_syscall-0.2.13
	regex-1.5.6
	regex-automata-0.1.10
	regex-syntax-0.6.26
	remove_dir_all-0.5.3
	roxmltree-0.14.1
	rustversion-1.0.6
	ryu-1.0.10
	same-file-1.0.6
	serde-1.0.137
	serde_derive-1.0.137
	serde_json-1.0.81
	strsim-0.10.0
	syn-1.0.96
	tap-1.0.1
	tempfile-3.3.0
	termcolor-1.1.3
	terminal_size-0.1.17
	termtree-0.2.4
	textwrap-0.15.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	thread_local-1.1.4
	time-0.3.9
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	unicode-bidi-0.3.8
	unicode-ident-1.0.0
	unicode-normalization-0.1.19
	url-2.2.2
	vcpkg-0.2.15
	vergen-7.2.1
	version_check-0.9.4
	wait-timeout-0.2.0
	walkdir-2.3.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	wyz-0.5.0
	xmlparser-0.13.3
"

inherit cargo git-r3

DESCRIPTION="CLI tool combining multiple utilities for working with Dolby Vision"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/quietvoid/dovi_tool"
SRC_URI="$(cargo_crate_uris)"
EGIT_COMMIT="${PV}"
EGIT_REPO_URI="https://github.com/quietvoid/dovi_tool.git"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="0BSD Apache-2.0 BSD Boost-1.0 MIT Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+capi"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
		>=virtual/rust-1.61.0
		capi? ( >=dev-util/cargo-c-0.6.3 )
"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN} usr/lib.*/${PN}.* usr/bin/libdovi usr/lib.*/libdovi.*"

src_unpack() {
	cargo_src_unpack
	git-r3_src_unpack
}

src_compile() {
	#export CARGO_HOME="${ECARGO_HOME}"
	#local args=$(usex debug "" --release)

	cargo_src_compile
	#cargo build ${args} || die "cargo build failed"

	if use capi; then
		cargo cbuild ${args} --target-dir="dolby_vision" \
			--prefix="/usr" --libdir="/usr/$(get_libdir)" \
			--library-type=cdylib \
			--manifest-path="${WORKDIR}/${P}/dolby_vision/Cargo.toml" \
			|| die "cargo cbuild failed"
	fi
}

src_install() {
	export CARGO_HOME="${ECARGO_HOME}"
	local args=$(usex debug --debug "")

	if use capi; then
		cargo cinstall ${args} --target-dir="dolby_vision" \
			--prefix="/usr" --libdir="/usr/$(get_libdir)" --destdir="${ED}" \
			--library-type=cdylib \
			--manifest-path="${WORKDIR}/${P}/dolby_vision/Cargo.toml" \
			|| die "cargo cinstall failed"
	fi
	cargo_src_install
}
