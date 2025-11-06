#!/bin/bash

#Author : Limeeee48
#poC

BoldWhite="\e[1;37m"
EndLine="\e[0m"
sucessColor="\e[32m"
ErrorColor="\e[31m"
first_url="(https?://)?(www\.)?[A-Za-z0-9_]+\.(com|net|org|gov)(/[0-9A-Za-z/_]+)?"
#first_url="https?://(www\.)?[A-Za-z0-9_]+\.(com|net|org|gov)(/[0-9A-Za-z/_]+)?"
dll_="^[a-zA-Z0-9_]+\.dll$"
banner()
{
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
			cat $domains | sort -u
			rm -rf $tmpfile $domains
		else 
			echo -e "${ErrorColor}No Domains Found .${EndLine}"
		fi
	else 
		echo -e "${ErrorColor}[-] File $1 Not Found${EndLine}"
	fi
fi
}
banner
getdomains $1

