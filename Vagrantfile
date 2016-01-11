# vi: set ft=ruby :
# vim: set sw=2 :

# some inspiration from https://github.com/redhat-developer-tooling/openshift-vagrant

# constants
NO_VAGRANT_REGISTRATION_ERROR = "vagrant-registration plugin is not installed, run `vagrant plugin install vagrant-registration` to install the plugin."

Vagrant.configure(2) do |config|

  # check for registration plugin
  unless Vagrant.has_plugin?('vagrant-registration')
    raise Vagrant::Errors::VagrantError.new, NO_VAGRANT_REGISTRATION_ERROR
  end

  # ensure all systems are registered to RHSM
  config.registration.username    = ENV.has_key?('SUB_USERNAME') ? "#{ENV['SUB_USERNAME']}" : nil
  config.registration.password    = ENV.has_key?('SUB_PASSWORD') ? "#{ENV['SUB_PASSWORD']}" : nil
  config.registration.auto_attach = true

  # configure defaults for virtualbox
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
    v.linked_clone = true
  end

  config.vm.provider "libvirt" do |libvirt, override|
    libvirt.cpus = 2
    libvirt.memory = 1024
    libvirt.driver = 'kvm'
  end

  # the ssh key configuration is basically identical for all vms
  def ssh_provision(boxdef)
    boxdef.vm.provision :file, source: "ose.key", destination: "~/.ssh/id_rsa"
    boxdef.vm.provision :file, source: "ose.pub", destination: "~/.ssh/id_rsa.pub"
    boxdef.vm.provision :shell, path: "sshsetup.sh"
  end

  # need to fix the fqdn hostname as the loopback address in /etc/hosts
  # http://stackoverflow.com/questions/33117939/vagrant-do-not-map-hostname-to-loopback-address-in-etc-hosts
  def hostname_fix(boxdef)
    # Vagrant's "change host name" sets the short host name.
    # Before we undo the /etc/hosts silliness (see below) let's
    # reset /etc/hostname to the *full* host name
    #
    boxdef.vm.provision "shell",
      inline: "hostname --fqdn > /etc/hostname && hostname -F /etc/hostname"
    
    # Vagrant's "change host name" capability for Fedora
    # maps hostname to loopback, conflicting with hostmanager.
    # We must repair /etc/hosts
    #
    boxdef.vm.provision "shell",
      inline: "sed -ri 's/127\.0\.0\.1\s.*/127.0.0.1 localhost localhost.localdomain/' /etc/hosts"
  end

  # node2
  config.vm.define "node2" do |v|
    v.vm.box = "rhel-71-cdk"
    v.vm.network :private_network, ip: "192.168.144.4", :adapter => 2
    v.vm.hostname = "ose3-node2.example.com"
    v.vm.provision :shell, path: "prereq.sh", args: "notmaster"

    # ssh keys
    ssh_provision(v)

    # /etc/hosts fix
    hostname_fix(v)

    # set up dnsmasq on node2
    # this is done after fixing the hostname to prevent bad data from being served by dnsmasq
    v.vm.provision :file, source: "dnsmasq.conf", destination: "dnsmasq.conf"
    v.vm.provision :shell, path: "dnsmasq.sh"

  end

  # node1
  config.vm.define "node1" do |v|
    v.vm.box = "rhel-71-cdk"
    v.vm.network :private_network, ip: "192.168.144.3", :adapter => 2
    v.vm.hostname = "ose3-node1.example.com"
    v.vm.provision :shell, path: "prereq.sh", args: "notmaster"

    # ssh keys
    ssh_provision(v)

    # /etc/hosts fix
    hostname_fix(v)
  end

  # master
  # comes last because once this is ready we will run the installer
  config.vm.define "master" do |v|
    v.vm.box = "rhel-71-cdk"
    v.vm.network :private_network, ip: "192.168.144.2", :adapter => 2
    v.vm.hostname = "ose3-master.example.com"
    v.vm.provision :shell, path: "prereq.sh", args: "master"
    v.vm.provision :shell, inline: "mkdir -p .config/openshift", privileged: false
    v.vm.provision :file, source: "installer.cfg.yml", destination: ".config/openshift/installer.cfg.yml"

    # ssh keys
    ssh_provision(v)

    # /etc/hosts fix
    hostname_fix(v)

    # openshift installation
    v.vm.provision :shell, inline: "atomic-openshift-installer -vvvv -u install", privileged: false
  end

end
