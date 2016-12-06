# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen PCE Fast. (PC Engine/TurboGrafx-16)"
HOMEPAGE="https://github.com/libretro/beetle-pce-fast-libretro"
SRC_URI="https://github.com/libretro/beetle-pce-fast-libretro/archive/8daf99e71121e71e48d11dd3de6b395b909df2a0.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/beetle-pce-fast-libretro-8daf99e71121e71e48d11dd3de6b395b909df2a0"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/beetle-pce-fast-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_pce_fast

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") core=pce-fast || die "emake failed"
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to have the following files in your 'system_directory' folder:"
		ewarn "syscard3.pce (PCE-CD BIOS)"
		ewarn ""
		ewarn ""
	fi
}