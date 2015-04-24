#!/bin/bash
#
# VPN Tunnel routing script - force a specific domain through a VPN tunnel
#
# Usage will be made easier at a later date
#
# Copyright (C) 2014 B Tasker
# Released under GNU GPL V2
# See http://www.gnu.org/licenses/gpl-2.0.html
#
# Create the following file, with the following contents (change to suit)
#
# /root/.vpn_config
# INSTDIR='/root/VPNs'
#
# TODO: This script throws some avoidable warnings/errors, remove them

DN=$1
GW=$2
NAT=$3

if [ "$NAT" == "" ]
then

  echo "Usage: add_vpn_routing_by_name [Domain Name] [Gateway] [NAT IP]"
  exit 1

fi

# Load the config
source /root/.vpn_config

source $INSTDIR/config/config

# Run a nameserver lookup on the domain

IPS=$( host `echo $DNFIELD $UPSTREAM_DNS | awk -F\: '{print $1}'` | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' );

for i in $IPS
do
  # Add the IP to the routing but don't save it to the IP routing list
  $INSTDIR/scripts/add_vpn_routing_by_ip.sh $i $GW $NAT 1
done

# Save the domain name to a config file
echo "$DN:$GW:$NAT" >> $INSTDIR/config/domains

# TODO: A script to refresh the IPs used occassionally from the domains config file
