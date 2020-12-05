################################################################################
#
# pacman
#
################################################################################

PACMAN_VERSION = 5.2.2
PACMAN_SITE = https://git.archlinux.org/pacman.git/snapshot/
PACMAN_LICENSE = GPL-2.0
PACMAN_LICENSE_FILES = COPYING

HOST_PACMAN_DEPENDENCIES = host-libarchive host-libcurl
HOST_PACMAN_CONF_OPTS = -Dldconfig=/usr/bin/ldconfig

$(eval $(host-meson-package))
