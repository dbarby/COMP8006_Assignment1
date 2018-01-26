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