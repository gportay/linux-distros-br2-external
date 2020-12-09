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
