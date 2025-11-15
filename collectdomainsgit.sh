#!/bin/bash

#Author : Limeeee48
#poC

#Tool Colors : 
BoldWhite="\e[1m"
EndLine="\e[0m"
sucessColor="\e[32m"
ErrorColor="\e[31m"
#Domian's , dll's , Ip's Regex : 
first_url="(https?://)?(www\.)?[A-Za-z0-9_]+\.(com|net|org|gov)(/[0-9A-Za-z/_]+)?"
dll_="^[a-zA-Z0-9_\-]+\.(dll|ocx|drv)$"
ips="(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}"
banner()
{
#Banner
echo -e """${sucessColor}
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣀⣠⣤⣴⣶⡶⢿⣿⣿⣿⠿⠿⠿⠿⠟⠛⢋⣁⣤⡴⠂⣠⡆⠀
⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣶⣤⣤⣤⣤⣤⣴⣶⣶⣿⣿⣿⡿⠋⣠⣾⣿⠁⠀
⠀⠀⠀⠀⠀⢀⣴⣤⣄⡉⠛⠻⠿⠿⣿⣿⣿⣿⡿⠿⠟⠋⣁⣤⣾⣿⣿⣿⠀⠀
⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣶⣶⣤⣤⣤⣤⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⡇⠀
⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀
⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⡟⢸⡟⠀⠀
⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣷⡿⢿⡿⠁⠀⠀
⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢁⣴⠟⢀⣾⠃⠀⠀⠀
⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⣉⣿⠿⣿⣶⡟⠁⠀⠀⠀⠀
⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⣿⣏⣸⡿⢿⣯⣠⣴⠿⠋⠀⠀⠀⠀⠀⠀
⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠿⠶⣾⣿⣉⣡⣤⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢸⣿⣿⣿⣿⡿⠿⠿⠿⠶⠾⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠈⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀${BoldWhite}Author : LIME⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${EndLine}"""

}
#Main Function :
getdomains() 
{

if [ $# -eq 0 ] ; then 
	echo -e "${ErrorColor}Usage : collectdomains <EXE ,DLL, Script>${EndLine}";exit 1 
else 
	if [ -f "$1" ] ; then
        tmpfile=$(mktemp)  
		domains=$(mktemp)
		strings $1 > $tmpfile 
		cat $tmpfile | grep -Eo $first_url  > $domains
		if [ -n "$(cat $domains)" ] ; then 
			echo -e "${BoldWhite}\n============Domains============${EndLine}"
			cat $domains | sort -u | nl 
			rm -rf $domains
			Domains_Check_variable=0 		
		else 
			Domains_Check_variable=1
	fi
	else 
		echo -e "${ErrorColor}[-] File $1 Not Found${EndLine}";exit 1 
	fi
fi
#Dll's Files Section : 
DLLS=$(mktemp)
cat $tmpfile | grep -Eo "$dll_"  > $DLLS
if [ -n "$(cat $DLLS)" ] ; then 
	echo -e "${BoldWhite}\n============DLL'S============${EndLine}"
	cat $DLLS | sort -u | nl
	rm -rf $DLLS
	Dll_Check_variable=0
else 
	Dll_Check_variable=1 
fi

#Ips Section : 
Ips=$(mktemp)
cat $tmpfile | grep -Eo "$ips"  > $Ips
if [ -n "$(cat $Ips)" ] ; then 
	echo -e "${BoldWhite}\n============Ip's============${EndLine}"
	cat $Ips | sort -u | nl
	rm -rf  $Ips $tmpfile
	Ip_Check_Variable=0
else 
	Ip_Check_Variable=1 
fi

if [ $Domains_Check_variable -eq 1 ];then
	echo -e "${ErrorColor}\n[-] No Domains Found .${EndLine}"
fi
if [ $Dll_Check_variable -eq 1 ];then
	echo -e "${ErrorColor}[-] No Dll's Found .${EndLine}"
fi
if [ $Ip_Check_Variable -eq 1 ];then
	echo -e "${ErrorColor}[-] No Ip's Found .${EndLine}"
fi
}

banner
getdomains $1

