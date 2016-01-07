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
  
  # node2
  config.vm.define "node2" do |v|
    v.vm.box = "rhel-71-vbox"
    v.vm.network :private_network, ip: "192.168.144.4", :adapter => 2
    v.vm.hostname = "ose3-node2.example.com"
    v.vm.provision :shell, path: "prereq.sh"

    # set up dnsmasq on node2
    v.vm.provision :file, source: "dnsmasq.conf", destination: "dnsmasq.conf"
    v.vm.provision :shell, path: "dnsmasq.sh"

    # ssh keys
    v.vm.provision :file, source: "ose.key", destination: "~/.ssh/id_rsa"
    v.vm.provision :shell, inline: "chmod 600 /home/vagrant/.ssh/id_rsa"
    v.vm.provision :file, source: "ose.pub", destination: "~/.ssh/id_rsa.pub"
    v.vm.provision :shell, inline: "chmod 600 /home/vagrant/.ssh/id_rsa.pub"
    v.vm.provision :shell, inline: "cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end

  # node1
  config.vm.define "node1" do |v|
    v.vm.box = "rhel-71-vbox"
    v.vm.network :private_network, ip: "192.168.144.3", :adapter => 2
    v.vm.hostname = "ose3-node1.example.com"
    v.vm.provision :shell, path: "prereq.sh"

    # ssh keys
    v.vm.provision :file, source: "ose.key", destination: "~/.ssh/id_rsa"
    v.vm.provision :shell, inline: "chmod 600 /home/vagrant/.ssh/id_rsa"
    v.vm.provision :file, source: "ose.pub", destination: "~/.ssh/id_rsa.pub"
    v.vm.provision :shell, inline: "chmod 600 /home/vagrant/.ssh/id_rsa.pub"
    v.vm.provision :shell, inline: "cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end

  # master
  # comes last because once this is ready we will run the installer
  config.vm.define "master" do |v|
    v.vm.box = "rhel-71-vbox"
    v.vm.network :private_network, ip: "192.168.144.2", :adapter => 2
    v.vm.hostname = "ose3-master.example.com"
    v.vm.provision :shell, path: "prereq.sh", args: "master"
    v.vm.provision :file, source: "installer.cfg.yaml", destination: "installer.cfg.yaml"

    # ssh keys
    v.vm.provision :file, source: "ose.key", destination: "~/.ssh/id_rsa"
    v.vm.provision :shell, inline: "chmod 600 /home/vagrant/.ssh/id_rsa"
    v.vm.provision :file, source: "ose.pub", destination: "~/.ssh/id_rsa.pub"
    v.vm.provision :shell, inline: "chmod 600 /home/vagrant/.ssh/id_rsa.pub"
    v.vm.provision :shell, inline: "cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end

end
