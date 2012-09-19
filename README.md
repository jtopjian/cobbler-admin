Cobbler For Use in Deploying Ubuntu in Preparation for OpenStack
================================================================

Directory Contents
------------------
* kickstarts: contents go in `/var/lib/cobbler/kickstarts`
* snippets: contents go in `/var/lib/cobbler/snippets`
* www: contents go in `/var/www`

Basic Cobbler Installation
--------------------------
* `apt-get install cobbler cobbler-web debmirror dnsmasq`
* edit `/etc/cobbler/modules.conf`
    * Set to use dnsmasq
* edit /etc/cobbler/dnsmasq.template
    * Set dhcp range to proper range
    * Ensure dnsmasq is only listening on required interfaces!
* edit `/etc/cobbler/settings`
    * Set `manage_dns/dhcp` to on if needed
* `cobbler get-loaders`
* `cobbler sync`
* mount ubuntu iso
* `cobbler import --name=ubuntu-server-12.04 --path=/mnt --breed=ubuntu`
* `cobbler distro list` 
* Install apt-cacher:
    * `apt-get install apt-cacher-ng`

Ubuntu Configuration
--------------------
* Create profiles based on OpenStack roles
    * For example, Controller and Compute
    * Assign each role a seed file:
        * Included is `install-cc.seed` for Controller
        * `install-node.seed` for Compute
    * For each role/profile, make sure you add the following kernel option:
        * `netcfg/choose_interface=eth0 `
        * If this is not specified, the installer will prompt you to choose a NIC when multiple NICs are available, thus breaking the hands-off installation.

Ubuntu Deployment
-----------------
* Once profiles have been created, create a system for each physical server
* Type in the network and hostname information into the system config form
* Edit the cobbler scripts to suit your environment! Install sources, IP addresses, etc.

Puppet Configuration
--------------------
* Make sure `puppet_auto_setup` is set to `1` in `/etc/cobbler/settings`.
	* This triggers the Puppet setup in `snippets/ubuntu_late_command`
* Create a Puppet Master server (could be the same as the cobbler server).
* Edit `www/puppet.*` to suit your environment's needs.

Network Configuration
---------------------
I have modified the Cobbler network config scripts to allow advanced Ubuntu network configuration such as bonding and vlans. I'll add some examples soon.

This code is in the `snippets/ubuntu_late_command*` files.

It is important to note that if the network interface IS your primary outgoing interface, mark it as MANAGEMENT. Otherwise more than one interface will get your default gateway and networking will not start due to errors.

Seed Descriptions
-----------------
A few hacks had to be done to get the debian-installer preseed to work correctly.

The first hack is the `early_command` hack. Debian/Ubuntu preseeding is horrible for advanced hard disk partitioning (such as RAID and LVM). To get around this, a shell script overrides the normal partitioner and manually issues partitioning commands. See `www/early_command_*` for exact commands. More information about this can be found [here](http://ubuntuforums.org/showthread.php?t=1495473).

The second hack is to apply the static network configuration after the install is done. See the Network Configuration section for more details on this.

The third hack is described in Ubuntu Configuration regarding multiple NICs.
