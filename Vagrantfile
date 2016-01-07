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

  # configure defaults for virtualbox
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
  end
  
  # master
  config.vm.define "master" do |v|
    v.vm.box = "rhel-71-vbox"
    v.vm.network :private_network, ip: "192.168.144.2", :adapter => 2
    v.vm.hostname = "ose3-master.example.com"
    v.vm.provision :shell, path: "prereq.sh"
  end

  # node1
  config.vm.define "node1" do |v|
    v.vm.box = "rhel-71-vbox"
    v.vm.network :private_network, ip: "192.168.144.3", :adapter => 2
    v.vm.hostname = "ose3-node1.example.com"
    v.vm.provision :shell, path: "prereq.sh"
  end

  # node2
  config.vm.define "node2" do |v|
    v.vm.box = "rhel-71-vbox"
    v.vm.network :private_network, ip: "192.168.144.4", :adapter => 2
    v.vm.hostname = "ose3-node2.example.com"
    v.vm.provision :shell, path: "prereq.sh"
  end

  config.registration.username    = ENV.has_key?('SUB_USERNAME') ? "#{ENV['SUB_USERNAME']}" : nil
  config.registration.password    = ENV.has_key?('SUB_PASSWORD') ? "#{ENV['SUB_PASSWORD']}" : nil
  config.registration.auto_attach = true
end
