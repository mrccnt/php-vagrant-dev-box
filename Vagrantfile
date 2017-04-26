Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "development.dev"
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", type: "dhcp"
  # config.vm.network "public_network"
  config.vm.synced_folder ".", "/var/www/development"
  config.vm.provision :shell, :path => "provision.sh"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--name", "PHP Developer Box"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.gui = false
  end
end