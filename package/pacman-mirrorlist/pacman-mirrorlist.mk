################################################################################
#
# pacman-mirrorlist
#
################################################################################

PACMAN_MIRRORLIST_VERSION = 20201031-1
PACMAN_MIRRORLIST_SITE = http://mirrors.evowise.com/archlinux/core/os/x86_64
PACMAN_MIRRORLIST_SOURCE= pacman-mirrorlist-$(PACMAN_MIRRORLIST_VERSION)-any.pkg.tar.zst
ifeq ($(BR2_aarch64),y)
PACMAN_MIRRORLIST_VERSION = 20200808-1
PACMAN_MIRRORLIST_SITE = http://mirror.archlinuxarm.org/aarch64/core/
PACMAN_MIRRORLIST_SOURCE= pacman-mirrorlist-$(PACMAN_MIRRORLIST_VERSION)-any.pkg.tar.xz
endif
PACMAN_MIRRORLIST_LICENSE = GPL-2.0
PACMAN_MIRRORLIST_STRIP_COMPONENTS = 0

define HOST_PACMAN_MIRRORLIST_INSTALL_CMDS
	$(INSTALL) -D $(@D)/etc/pacman.d/mirrorlist $(HOST_DIR)/etc/pacman.d/mirrorlist
endef

$(eval $(host-generic-package))
