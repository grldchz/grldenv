Vagrant.configure("2") do |config|

	config.trigger.before :halt do |trigger|
	  trigger.warn = "Running docker-compose down"
	  trigger.run_remote = {inline: "cd /grldenv && docker-compose down"}
	end
	#config.trigger.after :up do |trigger|
	#	trigger.info = "Running docker-compose up -d"
	#	trigger.run_remote = {inline: "cd /grldenv && sudo -u vagrant docker-compose up -d"}
	#end

    #configure the ubuntu box
    config.vm.define "grldenv", autostart: true do |server_config|
        #use ubuntu 20 for the OS
        server_config.vm.box = "bento/ubuntu-20.04"
        server_config.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--memory", 8388]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end

        # specify the synced folder options
        server_config.vm.synced_folder ".", "/grldenv", mount_options: ["dmode=777,fmode=777"]

        #forward the ports
        #apache
        server_config.vm.network "forwarded_port", guest: 80, host: 80
        server_config.vm.network "forwarded_port", guest: 443, host: 443
        #mysql
        server_config.vm.network "forwarded_port", guest: 3306, host: 3306
        #docker
        server_config.vm.network "forwarded_port", guest: 2375, host: 2375

        #set up this vm with docker
        server_config.vm.provision "shell", inline: "echo 'cd /grldenv' >> /home/vagrant/.bashrc"
        server_config.vm.provision "shell", inline: "echo 'alias docker=\"sudo docker -H localhost\"' >> /home/vagrant/.bashrc"
        server_config.vm.provision "shell", inline: "echo 'vm.max_map_count=262144' >> /etc/sysctl.conf"
        server_config.vm.provision "shell", inline: "sysctl -p"
        server_config.vm.provision "shell", inline: "apt-get update && apt-get install docker.io docker-compose vim unzip zip -y"
        server_config.vm.provision "shell", inline: "sed -i 's/fd:\\/\\/\\s--containerd=\\/run\\/containerd\\/containerd\\.sock/tcp:\\/\\/0\\.0\\.0\\.0:2375/g' /lib/systemd/system/docker.service"
        server_config.vm.provision "shell", inline: "systemctl daemon-reload"
        server_config.vm.provision "shell", inline: "systemctl enable docker"
        server_config.vm.provision "shell", inline: "service docker restart"
        server_config.vm.provision "shell", run: "always", privileged: "false", inline: "service docker start && cd /grldenv && docker-compose up -d"
    end
end
