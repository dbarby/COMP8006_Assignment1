#!/bin/bash
# ------------------------------------------------------------------
# File name 	: firewall.sh
# 
# Description	: COMP8006_Assignment 1
#				  Personal Firewall
#
# Author		: Arnold Myint (A00930841)
#	
# Notes			: N/A
#------------------------------------------------------------------
#Set the default policies to DROP


#Permit inbound/outbound ssh packets.
iptables -A INPUT -p tcp --sport 22 ACCEPT
iptables -A INPUT -p tcp --dport 22 ACCEPT

iptables -A OUTPUT -p tcp --sport 22 ACCEPT
iptables -A OUTPUT -p tcp --dport 22 ACCEPT

#Permit inbound/outbound www packets.
#http
iptables -A OUTPUT -p tcp --sport 80 ACCEPT
iptables -A INPUT -p tcp --dport 80 ACCEPT

iptables -A INPUT -p tcp --sport 80 ACCEPT
iptables -A OUTPUT -p tcp --dport 80 ACCEPT

#https
iptables -A OUTPUT -p tcp --sport 443 ACCEPT
iptables -A INPUT -p tcp --dport 443 ACCEPT

iptables -A INPUT -p tcp --sport 443 ACCEPT
iptables -A OUTPUT -p tcp --dport 443 ACCEPT

#Drop inbound traffic to port 80 (http) from source ports less than 1024.
iptables -A INPUT -p tcp --dport 80 --sport 0:1023 -j DROP

#Drop all incoming packets from reserved port 0 as well as outbound traffic to port 0.
iptables -A INPUT -p tcp --dport 0 -j DROP
iptables -A INPUT -p tcp --sport 0 -j DROP

#allow DNS and DHCP traffic through so that your machine can function properly.
#DNS
iptables -A INPUT -p udp --sport 53
iptables -A OUTPUT -p udp --dport 53

#DHCP
iptables -A INPUT -p udp --sport 67:68 --dport 67:68
iptables -A OUTPUT -p udp --dport 67:68 --sport 67:68

