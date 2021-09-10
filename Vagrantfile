Vagrant.configure("2") do |config|
    config.vm.define vm_name="mitmproxy" do |node|
      node.vm.box = "vivien/bionic64"
      node.vm.hostname = "mitmproxy"
      node.vm.network "private_network", ip: "192.168.20.10"
      node.vm.provision "shell", path: "scripts/install-mitmproxy.sh", privileged: false
      node.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", "3072"]
    end
  end

    config.vm.define vm_name="tfe" do |tfe|
      tfe.vm.box = "vivien/bionic64"
      tfe.vm.hostname = "tfe"
      tfe.vm.network "private_network", ip: "192.168.20.11"
      tfe.vm.provision "shell", path: "scripts/install-tfe.sh", privileged: true
      tfe.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", "4096"]
        v.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end
end
