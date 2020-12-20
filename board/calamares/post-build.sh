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

if [[ -d "$TARGET_DIR/etc/calamares/" ]]
then
	ln -sf /etc/init.d/calamares "$TARGET_DIR/etc/runlevels/default/"
fi
