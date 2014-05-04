#!/bin/bash

# install dependencies - some modules expect legacy node binary hence nodejs-legacy
apt-get update && apt-get install -y git-core npm nodejs-legacy


if [ "$1" == "windows" ]; then
	# windows hosts don't play nicely with npm_modules, symlinks, long pathnames etc
	# so we move it away from our shared folder and into a ramdisk bound to local directory ;-)
	mkdir -m777 -p /{home/vagrant,vagrant}/node_modules
	grep node_modules /etc/fstab >/dev/null || echo "/home/vagrant/node_modules /vagrant/node_modules none bind 0 0" >> /etc/fstab
	mount /vagrant/node_modules
fi

# listen on every interface so that port forwarding works fine
sed -i 's#http-server -a localhost -p 8000#http-server -a 0.0.0.0 -p 8000#' /vagrant/package.json

# install npm dependencies (npm start will be nohup and background)
# so we want to see output here
cd /vagrant
npm install

# make sure permissions are right
chown vagrant:vagrant -R /vagrant /vagrant/node_modules

# one command less
grep vagrant ~vagrant/.bashrc >/dev/null || echo "cd /vagrant" >> ~vagrant/.bashrc

# some user info...
echo -en "\n\n\033[1;32mDone.\033[0m\n";
echo -en "Enter vagrant (\033[1;32mvagrant ssh\033[0m) and start test serwer (\033[1;32mnpm start\033[0m).\n\n"
