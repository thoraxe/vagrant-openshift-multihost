#/bin/bash

subscription-manager repos --disable="*"
subscription-manager repos \
--enable="rhel-7-server-rpms" \
--enable="rhel-7-server-extras-rpms" \
--enable="rhel-7-server-optional-rpms" \
--enable="rhel-7-server-ose-3.1-rpms"
yum -y install deltarpm
yum -y install wget vim-enhanced net-tools bind-utils tmux git
yum -y install atomic-openshift-utils
