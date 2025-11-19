#!/bin/bash

#Author : Limeeee48
#poC

#Tool Colors : 
BoldWhite="\e[1;1m"
EndLine="\e[0m"
sucessColor="\e[32m"
white="\033[0;97m"
ErrorColor="\e[31m"
#Domian's,dll's,Ip's regex: 
first_url="(https?://)?(www\.)?[A-Za-z0-9_]+\.(com|net|org|gov)(/[0-9A-Za-z/_]+)?"
dll_="^[a-zA-Z0-9_\-]+\.(dll|ocx|drv)$"
ips="(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}"
api_function="^([A-Z]){1}[a-z]+([A-Z]){1}[a-z0-9]+([A-Z]{1}[a-z0-9]+)?$"
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
⠀⠀⠈⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀
	${BoldWhite}Author : LIME${EndLine}"""

}

help()
{
cat <<EOF

Usage: ./$0 <EXE>

Description:
This tool automatically analyzes the given file using 'strings' and extracts:
  
1. DLL files
Detects any DLL names appearing inside the binary output.

2. Domains
Identifies domain names and subdomains found in the extracted strings.

3. IP addresses
Extracts IPv4 addresses using accurate pattern matching.
EOF
}

sudo_status=$(id -u)
check_sudo(){
if [[ $sudo_status -ne 0 ]];then
    echo -e "\n[-] script requires root privileges. Please run with sudo." ; exit 1  
fi
}

checknet()
{
 
#check 1 : 
if which curl &> /dev/null; then 
    if timeout 3 bash -c "curl google.com" &> /dev/null ; then
        return 0 
    elif [ $? -eq 7 ];then
       if timeout 3 bash -c "curl facebook.com" &> /dev/null ;then
            return 0 
        else 
            return 1 
        fi
    else 
        return 1 
    fi
#check 2 
elif which ping &> /dev/null;then
    if ping -c 3 google.com &>/dev/null ;then
        return 0 
    else 
        return 1
    fi
else
    echo "curl , ping not Found"
fi

}

install_rabin()
{
    if which rabin2 &> /dev/null ; then
        return 0 
    else
        if checknet ;then
            apt-get install radare2 -y &>/dev/null &&\
            return 0 ||\
            return 1
        else 
            return 1
        fi
    fi

}

#Main Function :
getdomains() 
{

if [ $# -eq 0 ] ; then 
	echo -e "${white}\n[-] Use '-h' or '--help'${EndLine}";exit 1 
else 
	if [[ "$1" == "--help" || "$1" == "-h" ]];then
		help ;exit 0

	elif [ -f "$1" ] ; then
		tmpfile=$(mktemp)  
		domains=$(mktemp)
		strings $1 > $tmpfile 
		cat $tmpfile | grep -Eo $first_url  > $domains
		if [ -n "$(cat $domains)" ] ; then 
			domains_found=$(cat $domains | sort -u | wc -l )
			echo -e "\n[+] Found ${domains_found} DOMAINS : "
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
	found_dlls=$(cat $DLLS | sort -u | wc -l)
	echo -e "\n[+] Found ${found_dlls} DLL'S : "
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
	found_ips=$(cat $Ips | sort -u | wc -l)
	echo -e "\n[+] Found ${found_ips} IP'S : "
	cat $Ips | sort -u | nl
	rm -rf  $Ips
	Ip_Check_Variable=0
else 
	Ip_Check_Variable=1 
fi

#Api Function Section
if install_rabin ;then
	winAPI=$(mktemp)
	rabin2 -i $1 | awk '{print $6}'&> $winAPI
	check_name=$(rabin2 -i $1 | awk '{print $6}'|xargs|wc -c)
	if [ -n "$(cat $winAPI)" ];then
		if [ $check_name -eq 5 ];then
			api_Check_Variable=1  
		else
			found_api=$(cat $winAPI | sort -u | wc -l)
			echo -e "\n[+] Found ${found_api} API'S : "
			cat $winAPI | sort -u | nl
			rm -rf $winAPI
			api_Check_Variable=0
		fi
	else
		api_Check_Variable=1
	fi
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
if install_rabin ; then
	if [ $api_Check_Variable -eq 1 ];then
		echo -e "${ErrorColor}[-] No Api's Found .${EndLine}"
	fi
fi
}
banner
check_sudo
getdomains $1

