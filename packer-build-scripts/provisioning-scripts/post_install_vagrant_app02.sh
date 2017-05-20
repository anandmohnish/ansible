#!/bin/bash 
set -e
set -v


# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/init-users
sudo cat /etc/sudoers.d/init-users


# Installing vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys

# Making changes to host file.
sudo mkdir -p /data
#chown www-data:www-data /data
sudo chmod 777 /data
cd /data
rm -fr *
#Getting master host file.
sudo wget https://raw.githubusercontent.com/anandmohnish/ansible/master/packer-build-scripts/data/hostfilemaster
cat /etc/hosts >hosts
cat hostfilemaster >>hosts
sudo mv /etc/hosts /etc/hosts.backup
sudo cp /data/hosts /etc/hosts
sudo chown root:root /etc/hosts
sudo chmod 644 /etc/hosts
sudo chown vagrant:vagrant ~/.ssh/authorized_keys

echo "All Done!"
