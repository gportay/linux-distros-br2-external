# Makefile for linux-distros-br2-external
#
# Copyright (C) 2020 by Gaël PORTAY <gael.portay@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#

override BR2_EXTERNAL += $(CURDIR)

.PHONY: _all
_all: all

buildroot/makefile: | buildroot
	ln -s $(CURDIR)/hackfile.mk $@

buildroot:
	git clone git clone https://git.buildroot.net/buildroot $@

%: | buildroot/makefile
	$(MAKE) -C buildroot $@ BR2_EXTERNAL="$(BR2_EXTERNAL)"
