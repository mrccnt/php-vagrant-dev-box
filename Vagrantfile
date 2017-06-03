Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "development.dev"
  config.vm.network "public_network"
  config.vm.synced_folder ".", "/var/www/development"
  config.vm.provision :shell, :path => "provision.sh"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--name", "PHP Developer Box"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.gui = false
  end
end