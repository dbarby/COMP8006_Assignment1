#!/bin/bash

#Connect to config file
source iptables.config

#Clear iptables rules
iptables -F

#Clear user-defined chains
iptables -X

#Set default policies to drop
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#Create chains
iptables -N in_defaultch
iptables -N out_defaultch
iptables -N in_sshch
iptables -N out_sshch
iptables -N in_wwwch
iptables -N out_wwwch
iptables -N in_dropch
iptables -N out_dropch

#create a jump to INPUT/OUTPUT chains
iptables -A INPUT -j in_defaultch
iptables -A OUTPUT -j out_defaultch
iptables -A INPUT -j in_sshch
iptables -A OUTPUT -j out_sshch
iptables -A INPUT -j in_wwwch
iptables -A OUTPUT -j out_wwwch
iptables -A INPUT -j in_dropch
iptables -A OUTPUT -j out_dropch

#create rule for default chain
iptables -I in_defaultch -p udp -i $INTERFACE --dport 67:68 --sport 67:68 -j ACCEPT
iptables -A in_defaultch -p udp -i $INTERFACE --sport 53 -j ACCEPT
iptables -A in_defaultch -i lo -j ACCEPT
iptables -A in_defaultch -p icmp --icmp-type echo-request -j ACCEPT

if [ -n "$allow_in_ports" ]
	then
	iptables -A in_defaultch -i $INTERFACE -p tcp -m multiport --dports $allow_in_ports -j ACCEPT
fi

iptables -A out_defaultch -p udp -o $INTERFACE --dport 53 -j ACCEPT
iptables -A out_defaultch -o lo -j ACCEPT
iptables -A out_defaultch -p icmp --icmp-type echo-request -j ACCEPT

if [ -n "$allow_out_ports" ]
	then
	iptables -A out_defaultch -o $INTERFACE -p tcp -m multiport --sports $allow_out_ports -j ACCEPT
fi

#Create rules for ssh chains
iptables -A in_sshch -i $INTERFACE -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A in_sshch -i $INTERFACE -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

iptables -A out_sshch -o $INTERFACE -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
iptables -A out_sshch -o $INTERFACE -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

#Create rules for www chains
iptables -A in_wwwch -p tcp -i $INTERFACE --sport 0:1023 --dport 80 -j DROP
iptables -A in_wwwch -i $INTERFACE -p tcp -m multiport --dports 80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A in_wwwch -i $INTERFACE -p tcp -m multiport --sports 80,443 -m state --state ESTABLISHED -j ACCEPT

iptables -A out_wwwch -o $INTERFACE -p tcp -m multiport --dports 80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A out_wwwch -o $INTERFACE -p tcp -m multiport --sports 80,443 -m state --state ESTABLISHED -j ACCEPT

#Create rules for drop chains
iptables -A in_dropch -p udp -i $INTERFACE --dport 0 -j DROP
iptables -A in_dropch -p udp -i $INTERFACE --sport 0 -j DROP
iptables -A in_dropch -p tcp -i $INTERFACE --dport 0 -j DROP
iptables -A in_dropch -p tcp -i $INTERFACE --sport 0 -j DROP
iptables -A in_dropch -p tcp -i $INTERFACE --tcp-flags SYN,ACK,FIN,RST SYN -j DROP

#Print IPTABLES list
iptables -L -n
