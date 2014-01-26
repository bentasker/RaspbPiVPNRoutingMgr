#!/bin/bash
#
# VPN Tunnel routing script - force a specific IP through a VPN tunnel
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

IP=$1
GW=$2
NAT=$3
NOSAVE=$4

if [ "$NAT" == "" ]
then

  echo "Usage: add_vpn_routing_by_ip [IP Address] [Gateway] [NAT IP]"
  exit 1

fi

# Load the config
source /root/.vpn_config


# Add the route/rule
route add $IP gw $GW
iptables -t nat -I POSTROUTING -d $IP -j SNAT --to-source $NAT



if [ ! "$NOSAVE" == "1" ]
then

DATE=$(date +'%Y-%m-%d %H:%M:%S')

cat << EOM >> $INSTDIR/config/routes

# Added with the route_by_ip script $DATE
route add $IP gw $GW

EOM


cat << EOM >> $INSTDIR/config/firewall

# Added with the route_by_ip script $DATE
iptables -t nat -I POSTROUTING -d $IP -j SNAT --to-source $NAT

EOM

fi
