#!/bin/sh

echo "pkg"
if [ ! -f /usr/local/sbin/pkg ]; then
    ASSUME_ALWAYS_YES=yes pkg bootstrap
fi

echo "virtualbox tools"
pkg install -y virtualbox-ose-additions
#echo 'ifconfig_em1="inet 10.6.66.42 netmask 255.255.255.0"' >> /etc/rc.conf
sysrc vboxguest_enable=yes
sysrc vboxservice_enable=yes

echo "sudo"
pkg install -y sudo wget nano
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /usr/local/etc/sudoers.d/vagrant

echo "insecure ssh key"
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh 
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O ~vagrant/.ssh/authorized_keys
chown -R vagrant ~vagrant/.ssh
chmod 600 ~vagrant/.ssh/authorized_keys

echo "bash for root and vagrant"
pkg install -y bash-static
chsh -s /usr/local/bin/bash root
chsh -s /usr/local/bin/bash vagrant

echo "nfs client"
sysrc nfs_client_enable=yes