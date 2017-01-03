# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="d25e927b35edd7bfec34e4203a1cd00724dc632b"
LIBRETRO_REPO_NAME="libretro/${PN/mednafen-snes/beetle-bsnes}"
inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen SNES. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/beetle-bsnes-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_snes

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") core=snes || die "emake failed"
}
