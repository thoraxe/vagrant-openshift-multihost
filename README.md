# Multi-Host OpenShift Enterprise via Vagrant
This repo contains a `Vagrantfile` and supporting content for standing up a
multi-host OpenShift Enterprise environment. It expects that you will use a RHEL
7.1+ box, that you have valid OpenShift subscriptions and that you meet various
other prerequisites.

It is designed to create an environment that supports the labs and tutorials in
the [OpenShift Training](https://github.com/openshift/training) repository.

## Prerequisites

The following software prerequisites must be met:
* Vagrant
* Virtualbox
* vagrant Virtualbox plugin
* vagrant-registration plugin

In addition, you will need a box containing RHEL 7.1 that has the name
"rhel-71-vbox". You could import the Red Hat Container Development Kit
Virtualbox image and give it that name -- this is how this `Vagrantfile` is
actually tested.

## Time
Vagrant is really slow to provision VMs, and this could much more easily be done
using snapshotting and various other tools in Virtualbox directly, but we'll get
there. Having to register the VMs individually takes quite a bit of time, too.

All times are for a T440s with SSD:

```
$ time vagrant up
...
real    5m14.941s
user    0m8.808s
sys     0m5.821s
```
