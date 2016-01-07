#!/bin/bash
cp /home/vagrant/dnsmasq.conf /etc/dnsmasq.conf
restorecon -rv /etc/dnsmasq.conf
systemctl enable dnsmasq
systemctl start dnsmasq
