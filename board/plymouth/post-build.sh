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

cmdline_add() {
	if [[ -e "$BINARIES_DIR/rpi-firmware/cmdline.txt" ]]
	then
		cmdline_del "$@"
		sed "1s,\$, ${*//,/\\,}," -i "$BINARIES_DIR/rpi-firmware/cmdline.txt"
	elif [[ -e "$TARGET_DIR/extlinux/extlinux.conf" ]]
	then
		cmdline_del "$@"
		sed "/append/s,\$, ${*//,/\\,}," -i "$TARGET_DIR/extlinux/extlinux.conf"
	else
		echo "Error: No such cmdline file" >&2
		return 1
	fi
}

cmdline_del() {
	if [[ -e "$BINARIES_DIR/rpi-firmware/cmdline.txt" ]]
	then
		for i in "${@//,/\\,}"
		do
			sed "1s, \?$i,,g" -i "$BINARIES_DIR/rpi-firmware/cmdline.txt"
		done
	elif [[ -e "$TARGET_DIR/extlinux/extlinux.conf" ]]
	then
		for i in "${@//,/\\,}"
		do
			sed "/append/s, \?$i,,g" -i "$TARGET_DIR/extlinux/extlinux.conf"
		done
	else
		echo "Warning: No such cmdline file" >&2
	fi
}

if [[ -x "$TARGET_DIR/bin/plymouthd" ]] ||
   [[ -x "$TARGET_DIR/sbin/plymouthd" ]] ||
   [[ -x "$TARGET_DIR/usr/bin/plymouthd" ]] || 
   [[ -x "$TARGET_DIR/usr/sbin/plymouthd" ]]
then
	cmdline_del "console=tty1"
	cmdline_add "splash" "plymouth.ignore-serial-consoles" "vt.global_cursor_default=0"
	vt+=("vt.color=0x38")
	vt+=("vt.default_red=0x00,0xaa,0xc7,0xaa,0x00,0xaa,0x34,0xaa,0xbb,0xff,0x55,0xff,0x55,0xff,0x55,0xff")
	vt+=("vt.default_grn=0x00,0x00,0xd3,0x55,0x00,0x00,0x98,0xaa,0xbb,0x55,0xff,0xff,0x55,0x55,0xff,0xff")
	vt+=("vt.default_blu=0x00,0x00,0xe0,0x00,0xaa,0xaa,0xdb,0xaa,0xbb,0x55,0x55,0x55,0xff,0xff,0xff,0xff")
	cmdline_add "${vt[@]}"
fi
