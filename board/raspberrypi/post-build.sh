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

mkdir -p "$TARGET_DIR/boot"
sed -e '\:/dev/mmcblk0p1 /boot auto :d' -i "$TARGET_DIR"/etc/fstab
echo "/dev/mmcblk0p1 /boot auto noauto,rw 0 0" >>"$TARGET_DIR"/etc/fstab
