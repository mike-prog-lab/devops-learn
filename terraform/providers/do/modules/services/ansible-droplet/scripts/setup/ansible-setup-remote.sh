#! /bin/bash

# Developed by Labit Training

#This script will prep the client machine for ansible automation scripts to be done. It does the following three things :
#   1. Install openssh server
#   2. Open firewall port 22
#   3. Install Python

# Please run this script with administrator privileges, you can run the script with following command
# chmod u+x remotemachine.sh
# sudo ./remotemachine.sh



#The following code will install openssh-server on the client
apt install openssh-server -y

#Enable the firewall
ufw enable

#The following code will allow firewall port 22 
ufw allow ssh

#The following code will install python
apt install python3 -y
