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
  nodes.each do |nodes|
    config.ssh.insert_key = false

    # Tendency of frequent key regeneration in vagrant means we'll just use this
    config.ssh.keys_only = false
    config.ssh.password = 'vagrant'
    config.vm.define nodes["name"], autostart: nodes["autostart"] do |node|
      node.vm.box = nodes["box"]
      node.vm.hostname = nodes["name"]
      node.vm.boot_timeout = nodes["timeout"]
      # node.vm.network "private_network", 
      node.vm.network nodes["network"], auto_config: nodes["autoconfignet"], ip: nodes["ip"], bridge: nodes["bridge"]
      node.vm.network "forwarded_port", guest: 22, host: nodes["sshport"], id: "ssh"
      node.vm.provider nodes["provider"] do |vb|
        vb.gui = nodes["gui"]
        vb.name = nodes["name"]
        vb.memory = nodes["ram"]
        vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
      end
      node.vm.provision "shell", path: nodes["provisioner"]
    end
  end
end
