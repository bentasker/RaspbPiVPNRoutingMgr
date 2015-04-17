#!/bin/bash
#
# Reload/Reprocess the routing config and apply the resulting rules
#
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

# Load the config
source /root/.vpn_config

# Handle the predefined IPs
source $INSTDIR/config/routes
source $INSTDIR/config/firewall


# Handle those specified by domain name

while read -r DNFIELD 
do

	# Run a nameserver lookup on the domain
	IPS=$( host `echo $DNFIELD 8.8.4.4 | awk -F\: '{print $1}'` | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' );
	GW=$(echo $DNFIELD | awk -F\: '{print $2}')
	NAT=$(echo $DNFIELD | awk -F\: '{print $2}')


	for i in $IPS
	do
	  # Add the IP to the routing but don't save it to the IP routing list
	  $INSTDIR/scripts/add_vpn_routing_by_ip.sh $i $GW $NAT 1
	done

done < $INSTDIR/config/domains
