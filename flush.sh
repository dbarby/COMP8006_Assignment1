#!/bin/bash
# ------------------------------------------------------------------
# File name 	: flush.sh
# 
# Description	: Flushes all iptables rules and chains
#
# Author		: Arnold Myint (A00930841)
#	
# Notes			: N/A
#------------------------------------------------------------------

iptables -F
iptables --flush

iptables -X

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

iptables -L

echo "========================================"
echo -e "\x1B[32miptables flushed!! \x1B[0m"
echo "========================================"