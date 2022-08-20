#!/bin/bash
################################################################
# NAME: antivirus.sh
# VERSION: 1.1
# DESCRIPTION: Script to scan and remove Linux viruses
# DATE OF CREATION: 08/14/2022
# WRITTEN BY: Luciano R. Nascimento
# E-MAIL: rovanni@gmail.com
# DISTRO: Debian-based Linux
# LICENSE: GPLv3
# PROJECT: https://github.com/rovanni/Script_antivirus_Linux
################################################################

function pause(){
###############################################################
# Function to create a pause
###############################################################
	read -s -n 1 -p "Press any key to continue . . ."
	echo ""
}

function update(){
################################################################
# Function to update the antivirus database
################################################################
	################# Update Clamav Antivirus Database ###############################
	echo "Updating antivirus database. Please wait!!!................................";
	echo ""
	sudo /etc/init.d/clamav-freshclam stop
	sudo /usr/bin/freshclam -v
	sudo /etc/init.d/clamav-freshclam start
	echo ""
	echo "Updated antivirus database!!!................................................. .............";
	echo ""
}

function header(){
################################################################
# Function to update the antivirus database
################################################################
	sudo chmod -R 777 /var/log/clamav/ #Write permission to folder
	echo >>/var/log/clamav/relscan.log #Write a blank space into file
	echo >>/var/log/clamav/relscan.log #Write a blank space into file
	echo ============================================================= >>/var/log/clamav/relscan.log #prints a line
	echo ----------- Virus Scan Report ----------- >>/var/log/clamav/relscan.log #Write header
	data=`date +%d/%m/%Y-%H:%M:%S` #Store day and time in the date variable
	echo Report generated day: ${date} >>/var/log/clamav/relscan.log #Write current date and time into file
	#echo >>/var/log/clamav/relscan.log #Write a blank space into the file
}

function closure(){
################################################################
# Function to update the antivirus database
################################################################
	data=`date +%d/%m/%Y-%H:%M:%S` #Store day and time in the date variable
	echo Verification finished: ${date} >>/var/log/clamav/relscan.log #Write current date and time into file
	echo ============================================================= >>/var/log/clamav/relscan.log #prints a line
	echo ""
	echo "Verification completed successfully............................................ .....[ OK ]";
	echo "Report generated in: /var/log/clamav/relscan.log................................... [ OK ]";
	echo "Clamscan command queries type: clamscan --help.................................";
	cat /var/log/clamav/relscan.log
	echo ""
	pause
}

x="antivirus"
menu()
{
while true $x != "antivirus"
do
clear
echo "==============================================================================="
echo "Script to help with virus removal!"
echo "In all check options the Database"
echo "from Clamav Antivirus and updated before scanning."
echo "Created by: Luciano R.N."
echo ""
echo "1)Scanning using multiple threads and removing viruses from home folder all files."
echo ""
echo "2)Scanning using multiple threads and scanning and removing viruses from the complete,"
echo "root folder up to 5MB files."
echo ""
echo "3)Checking and removing viruses from home folder all files."
echo ""
echo "4)Scanning and removing viruses from complete root folder up to 5MB files."
echo ""
echo "5)Install Clamav Antivirus"
echo ""
echo "6)Open latest virus scan report"
echo ""
echo "7)Exit program"
echo ""
echo "==============================================================================="
echo "Enter the desired option:"
read x
echo "Option informed ($x)"
echo "==============================================================================="

case "$x" in

	1)
		################# Update Clamav Antivirus Database ###############################
		update ##calls update function
		###################### Scan and remove home virus ################################
		echo
		echo "Checking and removing viruses from home folder. Please wait!!!.......................";
		echo
		header ## call header function
		sudo clamdscan --multiscan --fdpass --recursive /home/ --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --quiet >> /var/log/clamav/relscan.log #Checks and removes viruses and writes the report inside the file
		closure ##calls shutdown function

echo "================================================"
;;
	2)
		################# Update Clamav Antivirus Database ########################### ###
		update ##calls update function
		###################### Scan and remove HD virus ##################### ##########
		echo
		echo "Checking and removing viruses from home folder. Please wait!!!.......................";
		echo
		header ## call header function
		sudo clamdscan --multiscan --fdpass / --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --quiet >> /var/log/clamav/relscan.log #Check and remove the virus and writes the report inside the file
		closure ##calls shutdown function

echo "================================================"
;;
	3)
		################# Update Clamav Antivirus Database ########################### ###
		update ##calls update function
		###################### Scan and remove home virus ##################### ##########
		echo
		echo "Checking and removing viruses from the / folder. Please wait!!!.......................";
		echo
		header ## call header function
		sudo clamscan --recursive /home/ --bell --remove=yes -i --bytecode=yes --bytecode-timeout=5000 >> /var/log/clamav/relscan.log #Checks and removes viruses and writes the report inside the file
		closure ##calls shutdown function

echo "================================================"

	4)
		################# Update Clamav Antivirus Database ########################### ###
		update ##calls update function
		###################### Scan and remove HD virus ##################### ##########
		echo
		echo "Checking and removing viruses from the / folder. Please wait!!!.......................";
		echo
		header ## call header function
		sudo clamscan --recursive / --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --bell --remove=yes -i >> /var/log/clamav/relscan.log #Checks and removes viruses and writes the report inside the file
		closure ##calls shutdown function

echo "================================================"


;;
	5)
		echo "Installing Antivirus..."
		sudo apt-get update && sudo apt-get install clamav clamav-daemon clamav-freshclam clamtk -y
		sudo /etc/init.d/clamav-freshclam stop
		sudo /usr/bin/freshclam -v
		sudo /etc/init.d/clamav-freshclam start
		echo ""
		echo "Antivirus Installed!"
		sleep 5

echo "================================================"
;;
	6)
		echo "Open latest virus scan report..."
		cat /var/log/clamav/relscan.log
		echo ""
		echo ""
		echo ""		
		pause	

echo "================================================"
;;
	7)
		echo "Exiting..."
		sleep 1
		clear;
		exit 1		
echo "================================================"
;;
	*)
		echo "Invalid option!"
esac
done

}
menu