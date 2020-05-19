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
servers = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yaml'))

# Create boxes
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Iterate through entries in YAML file
  servers.each do |servers|
    config.ssh.insert_key = false
    config.vm.define servers["name"], autostart: servers["autostart"] do |srv|
      srv.vm.box = servers["box"]
      srv.vm.hostname = servers["name"]
      srv.vm.boot_timeout = servers["timeout"]
      # srv.vm.network "private_network", 
      srv.vm.network servers["network"], auto_config: servers["autoconfignet"], ip: servers["ip"], bridge: servers["bridge"]
      srv.vm.provider servers["provider"] do |vb|
        vb.gui = servers["gui"]
        vb.name = servers["name"]
        vb.memory = servers["ram"]
        vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
      end
      srv.vm.provision "shell", path: servers["provisioner"]
    end
  end
end
