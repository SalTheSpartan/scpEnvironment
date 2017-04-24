required_plugins = ["vagrant-hostsupdater" , "vagrant-berkshelf"]
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
$script = <<SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
SCRIPT


Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: $script
  config.vm.define "rails" do |rails|
    # rails.berkshelf.berksfile_path = "cookbooks/rails-server/Berksfile"
    rails.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
    rails.vm.box = "ubuntu/xenial64"
    rails.vm.network "private_network", ip: "192.168.10.100"
    rails.hostsupdater.aliases = ["development.local"]
     # config.vm.provision "file", source: "nginx.default", destination: "nginx.default"
     rails.vm.synced_folder "../SpartaGram", "/home/ubuntu/app"
     # config.vm.provision "shell", path: "provision.sh"
     rails.vm.provision "chef_solo" do |chef|
       chef.cookbooks_path = ['cookbooks']
       chef.run_list =['recipe[rails-server::default]']
     end
  end


  config.vm.define "db" do |db|
    # db.berkshelf.berksfile_path = "cookbooks/postgresql/Berksfile"
    db.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.150"
    db.hostsupdater.aliases = ["database.local"]

    db.vm.provision :shell, :path => "provision.sh"
    db.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = ['cookbooks']
      chef.run_list =['recipe[postgresql::default]']
    end
  end
end
