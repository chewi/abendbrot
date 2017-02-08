# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/pcsx_rearmed"
LIBRETRO_COMMIT_SHA="abaa8b9e916f689ba162a684c2e23890cea7d6da"
inherit libretro-core

DESCRIPTION="libretro implementation of PCSX ReARMed. (PlayStation)"
HOMEPAGE="https://github.com/libretro/pcsx_rearmed"
KEYWORDS="~amd64 ~x86 ~arm"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug neon"

DEPEND="media-libs/libpng:0
	sys-libs/zlib"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=pcsx_rearmed

src_prepare() {
	epatch "${FILESDIR}"/include.patch
	#don't error out with unknown options
	sed -i configure \
                -e 's/*) echo "ERROR: unknown option $opt"; show_help="yes"/*) echo "unknown option $opt"/' \
                || die
	default_src_prepare
}

src_configure() {
	econf \
		--platform=libretro \
		$(use_enable neon ) \
		$(use_enable arm dynarec )
}

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}

src_install() {
	mv "${S}"/libretro.so "${S}"/pcsx_rearmed_libretro.so
	libretro-core_src_install
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
		elog "scph5500.bin md5sum = 8dd7d5296a650fac7319bce665a6a53c"
		elog "scph5501.bin md5sum = 490f666e1afb15b7362b406ed1cea246"
		elog "scph5502.bin md5sum = 32736f17079d0b2b7024407c39bd3050"
		elog ""
		ewarn ""
	fi
}