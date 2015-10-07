#!/bin/sh
#
# Script Name: sles11_trak_init.sh
# Author: Tony Pepper
# Version: 0.1
# Last Modified By:       Murray Oldfield
# Description:
#  This script configures kernel parameters in preparation for a TrakCare installation.
#  This script has been tested on SLES11SP4 and designed for Azure deployment provisioned via JSON template.
# 
# Sample:	
#  sh sles11_trak_init.sh
# ---

# Set constant variables
# set administrator user
OPT_USER="trakadmin"

# set directory
OPT_DIRECTORY="/trak"

# controls swappiness
SWAPPINESS="vm.swappiness=5"
# controls the percentage of active memory that can be filled with dirty pages before pdflush begins to write them.
DIRTYBACKRATIO="vm.dirty_background_ratio=5"
# controls the percentage of total memory that can be filled with dirty pages before processes are forced to write dirty buffers.
DIRTYRATIO="vm.dirty_ratio=10"

# Configure kernel parameters
echo $SWAPPINESS >> /etc/sysctl.conf
echo $DIRTYBACKRATIO >> /etc/sysctl.conf
echo $DIRTYRATIO >> /etc/sysctl.conf

# Create users and groups
groupadd cachegrp -g 1001
groupadd cachemgr -g 1002
useradd cacheusr -m -u 1001
useradd cachesys -m -u 1002
sudo usermod -G cachemgr cachesys
sudo usermod -G cachegrp cacheusr


# Update Path
sudo touch /etc/profile.local
sudo chown trakadmin /etc/profile.local
sudo echo "PATH=$PATH:/sbin:/usr/sbin" >> /etc/profile.local
