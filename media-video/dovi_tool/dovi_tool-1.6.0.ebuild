# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

CRATES="
	aho-corasick-0.7.20
	anes-0.1.6
	anyhow-1.0.68
	assert_cmd-2.0.8
	assert_fs-1.0.10
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bitvec-1.0.1
	bitvec_helpers-2.0.1
	bstr-1.1.0
	bumpalo-3.11.1
	byteorder-1.4.3
	cast-0.3.0
	cc-1.0.78
	cfg-if-1.0.0
	ciborium-0.2.0
	ciborium-io-0.2.0
	ciborium-ll-0.2.0
	clap-3.2.23
	clap-4.0.32
	clap_derive-4.0.21
	clap_lex-0.2.4
	clap_lex-0.3.0
	console-0.15.4
	crc-3.0.0
	crc-catalog-2.2.0
	criterion-0.4.0
	criterion-plot-0.5.0
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.13
	crossbeam-utils-0.8.14
	difflib-0.4.0
	doc-comment-0.3.3
	either-1.8.0
	encode_unicode-0.3.6
	enum-iterator-1.2.0
	enum-iterator-derive-1.1.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	fastrand-1.8.0
	float-cmp-0.9.0
	fnv-1.0.7
	form_urlencoded-1.1.0
	funty-2.0.0
	getset-0.1.2
	git2-0.15.0
	globset-0.4.10
	globwalk-0.8.1
	half-1.8.2
	hashbrown-0.12.3
	heck-0.4.0
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hevc_parser-0.5.2
	idna-0.3.0
	ignore-0.4.19
	indexmap-1.9.2
	indicatif-0.17.2
	instant-0.1.12
	io-lifetimes-1.0.3
	is-terminal-0.4.2
	itertools-0.10.5
	itoa-1.0.5
	jobserver-0.1.25
	js-sys-0.3.60
	lazy_static-1.4.0
	libc-0.2.139
	libgit2-sys-0.14.1+1.5.0
	libz-sys-1.1.8
	linux-raw-sys-0.1.4
	log-0.4.17
	madvr_parse-1.0.1
	memchr-2.5.0
	memoffset-0.7.1
	minimal-lexical-0.2.1
	nom-7.1.2
	normalize-line-endings-0.3.0
	num-traits-0.2.15
	num_cpus-1.15.0
	number_prefix-0.4.0
	once_cell-1.17.0
	oorandom-11.1.3
	os_str_bytes-6.4.1
	percent-encoding-2.2.0
	pkg-config-0.3.26
	plotters-0.3.4
	plotters-backend-0.3.4
	plotters-svg-0.3.3
	portable-atomic-0.3.19
	predicates-2.1.5
	predicates-core-1.0.5
	predicates-tree-1.0.7
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.49
	quote-1.0.23
	radium-0.7.0
	rayon-1.6.1
	rayon-core-1.10.1
	redox_syscall-0.2.16
	regex-1.7.1
	regex-automata-0.1.10
	regex-syntax-0.6.28
	remove_dir_all-0.5.3
	roxmltree-0.17.0
	rustix-0.36.6
	rustversion-1.0.11
	ryu-1.0.12
	same-file-1.0.6
	scopeguard-1.1.0
	serde-1.0.152
	serde_derive-1.0.152
	serde_json-1.0.91
	strsim-0.10.0
	syn-1.0.107
	tap-1.0.1
	tempfile-3.3.0
	termcolor-1.1.3
	terminal_size-0.2.3
	termtree-0.4.0
	textwrap-0.16.0
	thiserror-1.0.38
	thiserror-impl-1.0.38
	thread_local-1.1.4
	time-0.3.17
	time-core-0.1.0
	time-macros-0.2.6
	tinytemplate-1.2.1
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	unicode-bidi-0.3.8
	unicode-ident-1.0.6
	unicode-normalization-0.1.22
	unicode-width-0.1.10
	url-2.3.1
	vcpkg-0.2.15
	vergen-7.5.0
	version_check-0.9.4
	wait-timeout-0.2.0
	walkdir-2.3.2
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	web-sys-0.3.60
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.0
	windows_aarch64_msvc-0.42.0
	windows_i686_gnu-0.42.0
	windows_i686_msvc-0.42.0
	windows_x86_64_gnu-0.42.0
	windows_x86_64_gnullvm-0.42.0
	windows_x86_64_msvc-0.42.0
	wyz-0.5.1
	xmlparser-0.13.5
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
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 MIT Unicode-DFS-2016 Unlicense ZLIB"
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
