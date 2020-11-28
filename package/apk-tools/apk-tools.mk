################################################################################
#
# apk-tools
#
################################################################################

APK_TOOLS_VERSION = 2.10.5
APK_TOOLS_SITE = $(call github,alpinelinux,apk-tools,v$(APK_TOOLS_VERSION))
APK_TOOLS_LICENSE = GPL-2.0

HOST_APK_TOOLS_DEPENDENCIES = host-openssl host-zlib

define HOST_APK_TOOLS_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) LUAAPK= CONFDIR=$(HOST_DIR)/etc/apk CFLAGS=$(HOST_CFLAGS) LDFLAGS="$(HOST_LDFLAGS)"
endef

define HOST_APK_TOOLS_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) LUAAPK= SBINDIR=$(HOST_DIR)/sbin LIBDIR=$(HOST_DIR)/lib CONFDIR=$(HOST_DIR)/etc/apk MANDIR=$(HOST_DIR)/share/man DOCDIR=$(HOST_DIR)/share/doc/apk CFLAGS=$(HOST_CFLAGS) LDFLAGS="$(HOST_LDFLAGS)" install
endef

$(eval $(host-generic-package))
