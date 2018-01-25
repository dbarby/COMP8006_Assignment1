#!/bin/bash
# ------------------------------------------------------------------
# File name 	: menu.sh
# 
# Description	: COMP8006_Assignment 1
#				  Personal Firewall Menu
#
# Author		: Arnold Myint (A00930841)
#	
# Notes			: N/A
#------------------------------------------------------------------

while true
do
	clear
  	echo "		
			╔════════════════════════════╗
			║   COMP 8006 Assignment #1  ║
			║         by Arnold M.       ║
			╚════════════════════════════╝
		"	
	 cat << 'MENU'
	1................................... Install iptables
 	2................................... Flush iptables
 	3................................... Configure fireware
 	4................................... Start Fireware
 	5................................... Quit


MENU
	echo '           Select one option, then Return >'
	read ltr rest
	case ${ltr} in
		#Install iptables
		[1])	dnf install iptables
			;;

		#Flush iptables
		[2])	sh flush.sh
			;;

		#Configure fireware
		[3])	vi firewall.sh
			;;

		#Start Fireware
		[4])	sh firewall.sh
			;;
			
		#Quit
		[5])	exit
			;;
		
		[Ee])	echo 	
			echo -n '	Enter file to edit >'
			read fn rest
			vi ${fn}	;;
		*)	echo; echo Unrecognized choice: ${ltr} ;;
	esac
	echo; echo ' Press Enter to continue.....'
	read rest
done