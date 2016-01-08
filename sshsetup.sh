#!/bin/bash
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa.pub
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/config
mkdir /root/.ssh
cp /home/vagrant/.ssh/* /root/.ssh/
chown -R root:root /root/.ssh
