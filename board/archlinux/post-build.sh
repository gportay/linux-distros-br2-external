#!/bin/bash
#
#  SPDX-License-Identifier: GPL-2.0+
#
#  This file is part of linux-distros-br2-external.
#
#  linux-distros-br2-external is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2.0 of the License, or (at your
#  option) any later version.

set -e

config_isset() {
	grep -Eq "^$1=" "$BR2_CONFIG"
}

sed -e '\:tmpfs /var tmpfs:d' -i "$TARGET_DIR"/etc/fstab
if  [[ -d "$TARGET_DIR/usr/share/factory/var" ]]
then
	mv "$TARGET_DIR/usr/share/factory/var"/* "$TARGET_DIR/var"
	rm -rf "$TARGET_DIR/usr/share/factory/var"
fi
if ! config_isset "BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW"
then
	mkdir -p "$TARGET_DIR/etc/systemd/tmpfiles.d"
	echo "tmpfs /var tmpfs mode=1777 0 0" >>"$TARGET_DIR/etc/fstab"

	rm -rf "$TARGET_DIR/usr/share/factory/var"
	mv "$TARGET_DIR/var" "$TARGET_DIR/usr/share/factory/var"
	mkdir -p "$TARGET_DIR/var"
	for i in "$TARGET_DIR/usr/share/factory/var/"* \
	         "$TARGET_DIR/usr/share/factory/var/lib/"* \
	         "$TARGET_DIR/usr/share/factory/var/lib/systemd/*"
	do
		[ -e "${i}" ] || continue
		j="${i#$TARGET_DIR/usr/share/factory}"
		if [ -L "${i}" ]; then
			printf "L+! %s - - - - %s\n" "${j}" "../usr/share/factory/${j}" || exit 1
		else
			printf "C! %s - - - -\n" "${j}" || exit 1
		fi
	done >"$TARGET_DIR/etc/tmpfiles.d/var-factory.conf"
fi

sed -e "\$a 127.0.0.1\tlocalhost" \
    -e "\$a ::1\tlocalhost" \
    -e '/^127.0.1.0/d' \
    -e '/^::1/d' \
    -i "$TARGET_DIR/etc/hosts"

mkdir -p "$TARGET_DIR/etc/systemd/system/"{multi-user.target.wants,sockets.target.wants,network-online.target.wants,multi-user.target.wants}
ln -sf /usr/lib/systemd/system/systemd-networkd.service "$TARGET_DIR/etc/systemd/system/dbus-org.freedesktop.network1.service"
ln -sf /usr/lib/systemd/system/systemd-networkd.service "$TARGET_DIR/etc/systemd/system/multi-user.target.wants/systemd-networkd.service"
ln -sf /usr/lib/systemd/system/systemd-networkd.service "$TARGET_DIR/etc/systemd/system/sockets.target.wants/systemd-networkd.socket"
ln -sf /usr/lib/systemd/system/systemd-networkd.service "$TARGET_DIR/etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service"
ln -sf /usr/lib/systemd/system/systemd-resolved.service "$TARGET_DIR/etc/systemd/system/dbus-org.freedesktop.resolve1.service"
ln -sf /usr/lib/systemd/system/systemd-resolved.service "$TARGET_DIR/etc/systemd/system/multi-user.target.wants/systemd-resolved.service"
