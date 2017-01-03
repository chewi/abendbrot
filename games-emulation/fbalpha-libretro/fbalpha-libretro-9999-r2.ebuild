# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit libretro-core

DESCRIPTION="Port of Final Burn Alpha to Libretro"
HOMEPAGE="https://github.com/libretro/fbalpha"
KEYWORDS=""

LICENSE="FBA"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	# Doesn't work properly with -O3 and sets its own depending on need.
	# https://github.com/stefan-gr/abendbrot/issues/42
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") -f makefile.libretro || die "emake failed"
}
