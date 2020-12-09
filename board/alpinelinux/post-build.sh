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

config_string() {
	sed -n "/^$1/s,.*=\"\(.*\)\",\1,p" "$BR2_CONFIG"
}

if config_isset "BR2_TARGET_GENERIC_GETTY"
then
	port="$(config_string "BR2_TARGET_GENERIC_GETTY_PORT")"
	rate="$(config_string "BR2_TARGET_GENERIC_GETTY_BAUDRATE")"
	term="$(config_string "BR2_TARGET_GENERIC_GETTY_TERM")"
	opts="$(config_string "BR2_TARGET_GENERIC_GETTY_OPTIONS")"

	line="$port::respawn:/sbin/getty -L${opts:+$opts} $port $rate $term"
	if ! grep -q "^$line\$" "$TARGET_DIR/etc/inittab"
	then
		cat <<EOF >>"$TARGET_DIR/etc/inittab"
# Put a getty on the serial port
$line
EOF
	fi

	if ! grep -q "^$port\$" "$TARGET_DIR/etc/securetty"
	then
		cat <<EOF >>"$TARGET_DIR/etc/securetty"
$port
EOF
	fi
fi

if config_isset "BR2_SYSTEM_DHCP"
then
	iface="$(config_string "BR2_SYSTEM_DHCP")"
	line="iface $iface inet dhcp"
	if ! grep -q "^$line\$" "$TARGET_DIR/etc/network/interfaces"
	then
		cat <<EOF >"$TARGET_DIR/etc/network/interfaces"
auto $iface
iface $iface inet dhcp
EOF
	fi
fi
