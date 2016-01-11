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
"rhel-71-cdk". You could import the Red Hat Container Development Kit
Virtualbox image and give it that name -- this is how this `Vagrantfile` is
actually tested.

## Environment Variables
You will need two environment variables set before you can use `vagrant up`:

* `SUB_USERNAME`: Your RHSM (customer portal) account username
* `SUB_PASSWORD`: Your RHSM (customer portal) password

These are the credentials that the vagrant-registration plugin will use to
register your systems. You will need a valid account with OpenShift
subscriptions for this to work.

## Time
We are using linked clones in the case of VirtualBox, which is the only
virtualization engine this has been tested against. 

All times are for a T440s with SSD:

```
$ time vagrant up
...
real    13m50.599s
user    0m11.558s
sys     0m7.285s
```
