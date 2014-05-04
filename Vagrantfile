# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# base distro - ubuntu 14.04 64bit
	config.vm.box_check_update = true
	config.vm.box = "ubuntu/trusty64"

	# define virtualmachine and basic configuration
	config.vm.define 'angular-seed' do |node|
		# forward ports
		config.vm.network "forwarded_port", guest: 8000, host: 8000

		# run provisioning script
		config.vm.provision "shell" do |s|
		    s.path = 'vagrant-provision.sh'
		    s.args = (RbConfig::CONFIG['host_os'] =~ /cygwin|mswin|mingw/ ? "windows" : "")
		    s.keep_color = true
		    s.privileged = true
	  	end
	end
end
