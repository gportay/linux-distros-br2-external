################################################################################
#
# skeleton-alpinelinux
#
################################################################################

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_ALPINELINUX_ADD_TOOLCHAIN_DEPENDENCY = NO
SKELETON_ALPINELINUX_ADD_SKELETON_DEPENDENCY = NO

SKELETON_ALPINELINUX_DEPENDENCIES = host-alpine-make-rootfs host-apk-tools host-fakechroot host-fakeroot

SKELETON_ALPINELINUX_PROVIDES = skeleton

SKELETON_ALPINELINUX_PACKAGES = $(call qstrip,$(BR2_PACKAGE_SKELETON_ALPINELINUX_PACKAGES))
SKELETON_ALPINELINUX_BRANCH = $(call qstrip,$(BR2_PACKAGE_SKELETON_ALPINELINUX_BRANCH))
SKELETON_ALPINELINUX_MIRROR = $(call qstrip,$(BR2_PACKAGE_SKELETON_ALPINELINUX_MIRROR))

ifneq ($(ARCH),$(HOSTARCH))
ifeq ($(BR2_x86_64),y)
SKELETON_ALPINELINUX_QEMU_STATIC = qemu-x64_64-static
endif

ifeq ($(BR2_aarch64),y)
SKELETON_ALPINELINUX_QEMU_STATIC = qemu-aarch64-static
endif

ifdef SKELETON_ALPINELINUX_QEMU_STATIC
define SKELETON_ALPINELINUX_INSTALL_QEMU_STATIC
	$(INSTALL) -D /usr/bin/$(SKELETON_ALPINELINUX_QEMU_STATIC) $(@D)/rootfs/usr/bin/$(SKELETON_ALPINELINUX_QEMU_STATIC)
endef
SKELETON_ALPINELINUX_PRE_BUILD_HOOKS += SKELETON_ALPINELINUX_INSTALL_QEMU_STATIC

define SKELETON_ALPINELINUX_REMOVE_QEMU_STATIC
	$(RM) -f $(@D)/rootfs/usr/bin/$(SKELETON_ALPINELINUX_QEMU_STATIC)
endef
SKELETON_ALPINELINUX_POST_BUILD_HOOKS += SKELETON_ALPINELINUX_REMOVE_QEMU_STATIC
endif
endif

define SKELETON_ALPINELINUX_BUILD_CMDS
	mkdir -p $(@D)/rootfs/
	( cd $(@D) && PATH=$(BR_PATH) QEMU_LD_PREFIX=$(@D)/rootfs APK_OPTS="--arch $(ARCH) --allow-untrusted" fakeroot -- fakechroot -- alpine-make-rootfs --packages "$(SKELETON_ALPINELINUX_PACKAGES)" --branch $(SKELETON_ALPINELINUX_BRANCH) --mirror-uri $(SKELETON_ALPINELINUX_MIRROR) $(@D)/rootfs )
endef

define SKELETON_ALPINELINUX_INSTALL_TARGET_CMDS
	$(call SYSTEM_RSYNC,$(@D)/rootfs,$(TARGET_DIR))
endef

$(eval $(generic-package))
