Raspberry Pi VPN Routing Manager
=================================


A simple set of scripts written to support my article on [using OpenVPN on a RaspberryPi to selectively route around Content Filtering/Censorship implemented at an ISP level](http://www.bentasker.co.uk/documentation/linux/260-usurping-the-bthomehub-with-a-raspberry-pi-part-4-using-a-vpn-to-tunnel-connections-to-specific-ips).

Makes a few assumptions that are quite likely only true if you've been working through the [article series](http://www.bentasker.co.uk/tags/172-raspberrypi-router), though they should be easy enough to identify and adjust for if you're trying to use on another system.

The article contains details on initial configuration and setup.



Usage
------

There are two main ways to add a route - by destination IP or destination FQDN. If you use the latter, a DNS lookup will be performed whenever the routes are refreshed.

> add\_vpn\_routing\_by\_ip.sh [dest ip] [gw ip] [nat ip] [Optional: 1 to prevent the route being saved for later refresh]

Or to add by Domain Name

> add\_vpn\_routing\_by\_name.sh [dest FQDN] [gw ip] [nat ip]




Known Issues
--------------

There's little to no input validation, so if you pass _add\_vpn\_routing\_by\_ip.sh_ a domain name, it'll fail but still write the details to the config files for later refresh - it won't cause any issues but is a little untidy.


