# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="091f5a5889c51c1d0dc7c433a79d4f318420fef3"
LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit libretro-core

DESCRIPTION="libretro implementation of NEStopia. (Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/nestopia"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/libretro"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
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
		ewarn "disksys.rom (Famicom Disk System BIOS)"
		ewarn ""
		ewarn ""
	fi
}
