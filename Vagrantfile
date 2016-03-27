# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "dummy"
  config.vm.box_check_update = false

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.ami = "ami-f80e0596"
    aws.instance_type = "t2.nano"
    #aws.region_config "ap-northeast-1" do |region|
    #  region.spot_instance = true
    #  region.spot_max_price = "0.1"
    #end
    aws.region = "ap-northeast-1"
    aws.availability_zone = "ap-northeast-1a"
    aws.keypair_name = ENV['AWS_KEYPAIR_NAME']
    aws.security_groups = "sg-0f2ef06b"
    aws.subnet_id = "subnet-1e556069"
    aws.associate_public_ip = true
    aws.user_data = "#!/bin/bash\necho 'Defaults:ec2-user !requiretty' > /etc/sudoers.d/99-vagrant-cloud-init-requiretty\nchmod 440 /etc/sudoers.d/99-vagrant-cloud-init-requiretty"
    aws.tags = {
      Name: 'vagrant-test/zabbix3-web',
      Description: "Boot from vagrant-aws"
    }

    override.ssh.username = "ec2-user"
    override.ssh.private_key_path = ENV['AWS_KEYPAIR_PATH']
  end

  #config.vm.provision :itamae do |itamae|
  #  itamae.sudo = true
  #  itamae.recipes = ['./bootstrap.rb']
  #  itamae.yaml = './properties/zabbix3-web.yaml'
  #end
end
