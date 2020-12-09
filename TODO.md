# TODO

The *linux-distros-br2-external* tree is in early stage of development. Here
lives the list of TODOs.

It aims to support the following distros and their derivative:

[x] [alpine linux] via `alpine-make-rootfs`
[x] [Arch Linux] via `pacstrap` ([Arch Linux ARM], [manjaro]...)
[ ] [debian] ([ubuntu]...) via `debootstrap`
[ ] [fedora] via `dnf`

Despite [Buildroot], [fakechroot] is the heart of the project and it needs some
environment for the and replacement.

## fakechroot

[ ] systemd-sysusers: create users at pacstrap, from the systemd install
    script.

## Arch Linux

### Installation guide

Complete the installation [guide].

[x] fstab: not applicable
[x] chroot: not applicable
[ ] timezone
[ ] localization
[ ] network configuration
[x] initramfs: not applicatble
[ ] root password
[x] bootloader: not applicable

### General recommentations

See the general [recommendations].

## Alpine Linux

See the installation [manual].

[alpine linux]: https://alpinelinux.org
[Arch Linux]: https://www.archlinux.org
[Arch Linux ARM]: https://archlinuxarm.org
[manjaro]: https://manjaro.org
[debian]: https://www.debian.org
[ubuntu]: https://ubuntu.com
[fedora]: https://getfedora.org
[fakechroot]: https://github.com/dex4er/fakechroot/wiki
[Buildroot]: https://buildroot.org
[guide]: https://wiki.archlinux.org/index.php/installation_guide
[recommendations]: https://wiki.archlinux.org/index.php/General_recommendations
[manual]: https://wiki.alpinelinux.org/wiki/Installation
