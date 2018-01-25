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
iptables -A INPUT -p tcp --dport 22
iptables -A OUTPUT -p tcp --sport 22