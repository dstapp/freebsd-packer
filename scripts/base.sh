#!/bin/sh

echo "pkg"
if [ ! -f /usr/local/sbin/pkg ]; then
    ASSUME_ALWAYS_YES=yes pkg bootstrap
fi

# root ca
pkg install -y ca_root_nss

# vbox guest extensions
pkg install -y virtualbox-ose-additions
sysrc vboxguest_enable=yes
sysrc vboxservice_enable=yes
sysrc vboxnet_enable=yes

cat <<'EOF' >> /boot/loader.conf
if_vtnet_load="YES"
vboxdrv_load="YES"
virtio_balloon_load="YES"
virtio_blk_load="YES"
virtio_scsi_load="YES"
autoboot_delay="-1"
EOF

# sudo
pkg install -y sudo wget nano
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /usr/local/etc/sudoers.d/vagrant

# vagrant ssh keys
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O ~vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant ~vagrant/.ssh
chmod 600 ~vagrant/.ssh/authorized_keys

# root ssh keys
mkdir /root/.ssh
chmod 700 /root/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /root/.ssh/authorized_keys
chown -R root:root /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# bash
pkg install -y bash-static
chsh -s /usr/local/bin/bash root
chsh -s /usr/local/bin/bash vagrant

# nfs client
sysrc nfs_client_enable=yes
sysrc mountd_flags="-r"
sysrc rpcbind_enable=yes
touch /etc/exports

# cleanup packages
pkg clean -ay

# clean history
cat /dev/null > /root/.history

# disable root login again
sed -i '' 's/PermitRootLogin yes/#PermitRootLogin no/g' /etc/ssh/sshd_config

# clean up disk sapce
rm -f /home/vagrant/*.iso
rm -rf /tmp/*
rm -rf /var/db/freebsd-update/files
mkdir /var/db/freebsd-update/files
rm -f /var/db/freebsd-update/*-rollback
rm -rf /var/db/freebsd-update/install.*
rm -rf /boot/kernel.old
rm -rf /usr/src/*
rm -f /*.core
rm -f /var/db/dhclient.leases.*
rm -f /var/db/pkg/repo-*.sqlite
rm -f /etc/ssh/ssh_host_*

dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY
sync
