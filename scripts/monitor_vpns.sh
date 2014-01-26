#!/bin/bash
#
# VPN Tunnel maintenance script
#
# Copyright (C) 2014 B Tasker
# Released under GNU GPL V2
# See http://www.gnu.org/licenses/gpl-2.0.html
#
# Make sure your openvpn files contain 'daemon'
#
# Create the following file, with the following contents (change to suit)
#
# /root/.vpn_config
# INSTDIR='/root/VPNs'
#

source /etc/profile


# Load the config
source /root/.vpn_config


# Default our change monitor to No
CHANGES='no'

# Cycle through each of the VPNs
for i in `cat $INSTDIR/config/VPNS`
do

  # See if there's an instance running for this vpn

  /bin/ps aux | /bin/grep openvpn | /bin/grep "$i.conf" > /dev/null
  if [ "$?" == "1" ]
  then
    # Link seems to be down, bring it back up

    cd $INSTDIR/config/VPNs/$i
    /usr/sbin/openvpn "${i}.conf"

    # We've made changes
    CHANGES='yes'

  fi

done


# If we've brought a tunnel back up, we're probably going to want to resurrect routes etc
if [ "$CHANGES" == "yes" ]
then

  # Allow time for the tunnels to come up
  sleep 10
  source $INSTDIR/scripts/process_rules.sh

fi
