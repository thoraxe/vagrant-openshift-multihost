#/bin/bash

# set up repos
subscription-manager repos --disable="*"
subscription-manager repos \
--enable="rhel-7-server-rpms" \
--enable="rhel-7-server-extras-rpms" \
--enable="rhel-7-server-optional-rpms" \
--enable="rhel-7-server-ose-3.1-rpms"

# install basic prereq packages
#yum -y install deltarpm
yum -y install wget vim-enhanced net-tools bind-utils tmux git

if [ $1 == "master" ]
then
  yum -y install atomic-openshift-utils
fi

# configure the resolver
grep 144.4 /etc/resolv.conf
if [ $? -eq 1 ]
then
  sed -e '/^nameserver .*/i nameserver 192.168.144.4' -i /etc/resolv.conf
fi
