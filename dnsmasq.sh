#!/bin/bash
cp /home/vagrant/dnsmasq.conf /etc/dnsmasq.conf
restorecon -rv /etc/dnsmasq.conf
yum -y install iptables-services
systemctl enable iptables
systemctl restart iptables
iptables -I INPUT -p udp -m udp --dport 53 -j ACCEPT
systemctl enable dnsmasq
systemctl restart dnsmasq
