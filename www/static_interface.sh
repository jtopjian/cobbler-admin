#!/bin/sh

# This will need to be modified for bonded interfaces

echo "auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address $1
    netmask $2
    gateway $3
    dns-nameservers $4
" > /etc/network/interfaces
