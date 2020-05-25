# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.require_version ">= 2.2.7"
VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'

# Read YAML file with box details
# servers = YAML.load_file('servers.yaml')
nodes = YAML.load_file(File.join(File.dirname(__FILE__), 'nodes.yaml'))

# Create boxes
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Iterate through entries in YAML file
  nodes.each do |node|
    config.ssh.insert_key = false

    # Tendency of frequent key regeneration in vagrant means we'll just use this
    config.ssh.keys_only = false
    config.ssh.password = 'vagrant'
    config.vm.define node["name"], autostart: node["autostart"] do |srv|
      srv.vm.box = node["box"]
      srv.vm.hostname = node["name"]
      srv.vm.boot_timeout = node["timeout"]
      # srv.vm.network "private_network", 
      srv.vm.network node["network"], auto_config: node["autoconfignet"], ip: node["ip"], bridge: node["bridge"]
      ports = node["ports"]
      ports.each do |host_port, guest_port|
        srv.vm.network "forwarded_port", guest: guest_port, host: host_port, id: "#{guest_port}"
      end
      srv.vm.provider node["provider"] do |vb|
        vb.gui = node["gui"]
        vb.name = node["name"]
        vb.memory = node["ram"]
        vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
        vb.customize [ "modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end
      srv.vm.provision "shell", path: node["provisioner"]
    end
  end
end
