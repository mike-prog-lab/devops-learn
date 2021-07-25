#! /bin/bash

# Developed by Labit Training as course material for ansible master class

#This script needs to be run on Ansible Master server , it does the following 
#   1. Add Ansible repository
#   2. Update the system
#   3. Install Ansible
#   4. Check the version of Ansible installed

#Please run this script with administrator privileges, you can use the following command to run this script
# chmod u+x ansiblemaster.sh
# sudo ./ansiblemaster.sh


#The following code will add Ansible repository on the system
apt-add-repository ppa:ansible/ansible

#The following code will update system
apt update -y

#The following code will install ansible on the system
apt install ansible -y

#The following code will display the version of ansible installed
ansible --version
