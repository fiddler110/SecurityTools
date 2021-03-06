#!/bin/bash

function logo(){

cat << "EOF"
  

████████╗██╗    ██╗██╗ ██████╗  █████╗ 
╚══██╔══╝██║    ██║██║██╔════╝ ██╔══██╗
   ██║   ██║ █╗ ██║██║██║  ███╗███████║
   ██║   ██║███╗██║██║██║   ██║██╔══██║
   ██║   ╚███╔███╔╝██║╚██████╔╝██║  ██║
   ╚═╝    ╚══╝╚══╝ ╚═╝ ╚═════╝ ╚═╝  ╚═╝
                                       
EOF

	echo "Enumerate the Droid"
	echo " "
	echo "Version: 0.1.0 beta"
	echo "Developed by: Christian Kisutsa"
	echo ""
}


#++++++++++++
#AndroidEnum
#++++++++++++
#Check if option and codes file has been provided
if ! [ "$1" ] || [ "$1" == '-h' ] || [ "$1" == '--help' ] || ! [ "$2" ] ; then 
logo
echo "Usage:"
echo "[options] <report_name>"
echo ""
echo "Options:
-r, --report - enter report name
-h, --help   - print this help"
echo " "
echo "Example:
Generate report e.g $0 --report <report_name>"

exit -1
fi

bigline="================================================================================================="
smalline="-------------------------------------------------------------------------------------------------"

#===================
#Device information
#===================
function device_info(){
echo -e "[-]Device Info" | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Device:\t\t\t"`adb shell getprop ro.product.model` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Hostname:\t\t"`adb shell getprop net.hostname` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Serial:\t\t\t"`adb devices | sed -e '2p' -e '/device/d'| cut -f 1` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Baseband Version:\t"`adb shell getprop gsm.version.baseband` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Ril:\t\t\t"`adb shell getprop gsm.version.ril-impl` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Current phone type:\t"`adb shell getprop gsm.current.phone-type` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Version:\t\t"`adb shell getprop ro.baseband` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Board platform:\t\t"`adb shell getprop ro.board.platform` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Boot EMMC:\t\t\t"`adb shell getprop ro.boot.emmc` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Boot hardware:\t\t"`adb shell getprop ro.boot.hardware` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Boatloader:\t\t"`adb shell getprop ro.bootloader` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Build fingerprint:\t"`adb shell getprop ro.build.fingerprint` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Bootmode:\t\t"`adb shell getprop ro.bootmode` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Build characteristics:\t"`adb shell getprop ro.build.characteristics` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Build product:\t\t"`adb shell getprop ro.build.product` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Build id:\t\t"`adb shell getprop ro.build.id` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Build type:\t\t"`adb shell getprop ro.build.type` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Android version:\t"`adb shell getprop ro.build.version.release` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Security patch version:\t"`adb shell getprop ro.build.version.security_patch` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "SDK version:\t\t"`adb shell getprop ro.build.version.sdk` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Google clientidbase:\t"`adb shell getprop ro.com.google.clientidbase` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Crypto state:\t\t"`adb shell getprop ro.crypto.state` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Product brand:\t\t"`adb shell getprop ro.product.brand` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "CPU abi:\t\t"`adb shell getprop ro.product.cpu.abi` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "CPU abi2:\t\t"`adb shell getprop ro.product.cpu.abi2` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Manufacturer:\t\t"`adb shell getprop ro.product.manufacturer` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Global version:\t\t"`adb shell getprop sys.settings_global_version` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "Secure version:\t\t"`adb shell getprop sys.settings_secure_version` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "System version:\t\t"`adb shell getprop sys.settings_system_version` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "USB state:\t\t"`adb shell getprop sys.usb.state` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "MIC type:\t\t\t"`adb shell getprop persist.audio.handset.mic.type` | tee -a $report_name/$report_name.txt 2>/dev/null
echo -e "LteOnCdmaDevice:\t"`adb shell getprop telephony.lteOnCdmaDevice` | tee -a $report_name/$report_name.txt 2>/dev/null
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null
}

#===================
#Device features
#===================
function device_features(){
echo -e "[-]Device Features" | tee -a $report_name/$report_name.txt 2>/dev/null
adb shell "pm list features 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "$smalline" 
}

#===================
#Device properties
#===================
function device_properties(){
echo -e "[-]Kernel and System Information" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "cat /proc/version 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Hosts" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell  "cat /etc/hosts 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Check SELinux Status" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell getenforce | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Terminals" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "cat /proc/tty/* 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Available Devices" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "cat /proc/devices 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 
}

#=======
#Memory
#=======
function memory(){
echo -e "[-]Memory Information" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "cat /proc/meminfo 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Memory Partitions" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "cat /proc/partitions 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Swap Space"
adb shell "cat /proc/swaps 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 
}

#===========
#Services
#===========
function services(){
echo -e "[-]Running processes" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell ps | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null  

echo -e "[-]Running Thread Information" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell ps -t | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Processes running as root" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell ps | grep root | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Processes running as system" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell ps | grep "system " | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 
}

#===========
#Networking
#===========
function networking(){
echo -e "[-]Check network profiles" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "netcfg 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Nameservers" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "cat resolv.conf 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Route info" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "route 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Check network statistics" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "netstat 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]TCP info" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "netstat -antp 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]UDP info" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "netstat -anup 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

#echo -e "[-]Users/Hosts communicating" | tee -a $report_name/$report_name.txt 2>/dev/null 
#adb shell "lsof 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
#echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
#echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 
}

#===========
#Filesystem
#===========
function filesystem(){
echo -e "[-]Filesystems" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "cat /proc/filesystems 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo ""  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Get mount points" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "mount 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 
}

#=================
#File permisisons
#=================
function file_permissions(){
echo -e "[-]Checking root folder/file permisions" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "ls -al / 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null | tee -a $report_name/file_system/root.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Checking etc folder permisions" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell ls -lR "/etc/ 2>/dev/null" | tee -a $report_name/file_system/etc.txt 2>/dev/null 
echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Checking system folder permisions" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "ls -alR /system/ 2>/dev/null" | tee -a $report_name/file_system/system.txt 2>/dev/null 
echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Checking sys folder permisions" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "ls -alR /sys/ 2>/dev/null" | tee -a $report_name/file_system/sys.txt 2>/dev/null 
echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Checking proc folder permisions" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "ls -alR /proc/ 2>/dev/null" | tee -a $report_name/file_system/proc.txt 2>/dev/null 
echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

#These take a while to finish
#echo -e "[-]Check writable files"
#adb shell "find / -not -user shell -type f -not -path '/proc/*' -exec ls -alR {} \; 2>/dev/null" | grep '^\S*w\S*'
#echo ""

#echo -e "[-]Check execuable files"
#adb shell "find /etc -not -user shell -type f -not -path '/proc/*' -exec ls -alR {} \; 2>/dev/null" | grep '^\S*x\S*'
#echo ""
}

#============
#Environment
#============
function environment(){
echo -e "[-]Path info" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "echo \$PATH" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Environment info" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell env | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 
}

#=================
#Users and Groups
#=================
function user_app_groups(){
echo -e "[-]Current user/group info" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "id 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Users on the system" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell pm list users | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]App permission groups" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell pm list permission-groups | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline" | tee -a $report_name/$report_name.txt 2>/dev/null 

#Android GID info
#/data/system/packages.xml
#/data/system/packages.list
}

#=========
#Binaries
#=========
function system_binaries(){
echo -e "[-]Checking system binary permissions" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "ls -al /system/bin/ 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null | tee -a $report_name/binaries/bin.txt 2>/dev/null
adb shell "ls -al /system/xbin/ 2>/dev/null" | tee -a $report_name/$report_name.txt 2>/dev/null | tee -a $report_name/binaries/xbin.txt 2>/dev/null
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Extracting system binaries"  | tee -a $report_name/$report_name.txt 2>/dev/null 
#Extract binaries from /system/bin/ folder
mkdir -p $report_name/binaries/bin
adb shell "ls -l /system/bin/  2>/dev/null" | grep "shell" | cut -d ":" -f 2 | cut -d " " -f 2 >>  $report_name/binaries/cache.txt 
#sed 's/.$//' $report_name/binaries/cache.txt >> $report_name/binaries/buffer.txt
tr -d "\r" <  $report_name/binaries/cache.txt > $report_name/binaries/buffer.txt

	for binary in $(cat $report_name/binaries/buffer.txt); 
	do
		adb pull /system/bin/$binary $report_name/binaries/bin 2>/dev/null 
	done 
rm $report_name/binaries/cache.txt
rm $report_name/binaries/buffer.txt

#Extract binaries from /system/xbin/ folder
mkdir -p $report_name/binaries/xbin
adb shell "ls -l /system/xbin/  2>/dev/null" | grep "shell" | cut -d ":" -f 2 | cut -d " " -f 2 >>  $report_name/binaries/cache.txt 
tr -d "\r" <  $report_name/binaries/cache.txt > $report_name/binaries/buffer.txt

	for binary in $(cat $report_name/binaries/buffer.txt); 
	do
		adb pull /system/xbin/$binary $report_name/binaries/xbin 2>/dev/null  
	done 
rm $report_name/binaries/cache.txt
rm $report_name/binaries/buffer.txt

echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo ""  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline"  | tee -a $report_name/$report_name.txt 2>/dev/null 
}

#=============
#SDK versions
#=============
#Platform Version	API Level	VERSION_CODE
#Android 7.1.1		25		N_MR1
#Android 7.1 		25 		N_MR1 	
#Android 7.0 		24 		N 
#Android 6.0 		23 		M 	
#Android 5.1 		22 		LOLLIPOP_MR1
#Android 5.0 		21 		LOLLIPOP
#Android 4.4W 		20 		KITKAT_WATCH 	
#Android 4.4 		19 		KITKAT 	Platform 
#Android 4.3 		18 		JELLY_BEAN_MR2 
#Android 4.2, 4.2.2 	17 		JELLY_BEAN_MR1

function regular_apps(){
echo -e "[-]Extracting regular apps" | tee -a $report_name/$report_name.txt 2>/dev/null 
#List only user installed apps
#adb shell pm list packages -3

#List all user apps with package names
#adb shell pm list packages -f | grep "/data/app" | cut -d ":" -f 2

#Path to user installed apps
#adb shell pm list packages -f | grep "/data/app" | cut -d ":" -f 2 | cut -d "=" -f 1  

adb shell pm list packages -f | grep "/data/app" | cut -d ":" -f 2 | cut -d "=" -f 1 >> $report_name/apps/user_app/app_path.txt 2>/dev/null
sdk_version=`adb shell getprop ro.build.version.sdk`

if [[ "$sdk_version" > 20 ]]; then
	while read user_app;

	do	
		adb pull "$user_app" $report_name/apps/user_app/app/ 2>/dev/null 
		app_name=`echo "$user_app" | cut -d ":" -f 2 | cut -d "=" -f 1 | cut -d "/" -f 4`
		mv $report_name/apps/user_app/app/base.apk $report_name/apps/user_app/app/$app_name.apk	
		
	done <"$report_name/apps/user_app/app_path.txt"
fi

if [[ "$sdk_version" < 21 ]]; then
while read user_app;

	do	
		adb pull "$user_app" $report_name/apps/user_app/app/ 2>/dev/null 
		
	done <"$report_name/apps/user_app/app_path.txt"
fi

echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline"  | tee -a $report_name/$report_name.txt 2>/dev/null 
}

function system_apps(){
#List only system apps
#adb shell pm list packages -s

echo -e "[-]Extracting system apps" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb pull /system/app/ $report_name/apps/system_app 2>/dev/null 
echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "" | tee -a $report_name/$report_name.txt 2>/dev/null 

sdk_version=`adb shell getprop ro.build.version.sdk`
if [[ "$sdk_version" > 18 ]]; then
	echo -e "[-]Extracting privileged system apps" | tee -a $report_name/$report_name.txt 2>/dev/null 
	adb pull /system/priv-app/ $report_name/apps/system_app 2>/dev/null 
	echo ""
fi 

echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo ""  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline"  | tee -a $report_name/$report_name.txt 2>/dev/null 
}



#==========
#Libraries
#==========
function app_libraries(){
echo -e "[-]Extracting app libraries" | tee -a $report_name/$report_name.txt 2>/dev/null 

#pull app libs from /data/data/<app_name>/lib/
sdk_version=`adb shell getprop ro.build.version.sdk`

if [[ "$sdk_version" > 20 ]]; then
adb shell pm list packages -f | grep "/data/app" | cut -d ":" -f 2 | cut -d "=" -f 2 >> $report_name/libraries/buffer.txt 2>/dev/null

# IN UNIX ENVIRONMENT: convert DOS newlines (CR/LF) to Unix format.
#sed 's/.$//' # assumes that all lines end with CR/LF

sed 's/.$//' $report_name/libraries/buffer.txt > $report_name/libraries/app_lib.txt
#tr -d "\r" < $report_name/libraries/buffer.txt > $report_name/libraries/app_lib.txt
rm $report_name/libraries/buffer.txt

	for user_lib in $(cat $report_name/libraries/app_lib.txt); 
	do
		#mkdir -p $report_name/libraries/app-lib/$user_lib/	

		#Can only list library permissions but not pull them
		adb shell ls -alR /data/data/$user_lib/lib/ | tee -a $report_name/libraries/app_lib_permisions.txt 2>/dev/null
		#adb pull /data/data/$user_lib/lib/ $report_name/libraries/app-lib/
	done
fi
#rm $report_name/libraries/app_lib.txt
#pull app libs from /data/app-lib/
if [[ "$sdk_version" < 21 ]]; then
adb shell pm list packages -f | grep "/data/app" | cut -d ":" -f 2 | cut -d "=" -f 1 | cut -d "/" -f 4 | rev | cut -d "." -f 2- | rev >> $report_name/libraries/app_lib.txt 2>/dev/null

	for user_lib in $(cat $report_name/libraries/app_lib.txt); 
	do
		mkdir -p $report_name/libraries/app-lib/$user_lib/	
		#adb shell ls -alR /data/app-lib/$user_lib
		adb shell ls -alR /data/app-lib/$user_lib | tee -a $report_name/libraries/app_lib_permisions.txt 2>/dev/null	
		adb pull /data/app-lib/$user_lib $report_name/libraries/app-lib/ 2>/dev/null 
	done 
fi

echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 		
echo ""  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline"  | tee -a $report_name/$report_name.txt 2>/dev/null 
}

function system_libraries(){
echo -e "[-]Libraries supported by the current device" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell pm list libraries | tee -a $report_name/$report_name.txt 2>/dev/null | tee -a $report_name/libraries/supported_libs.txt 2>/dev/null
echo ""  | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Checking system library permissions" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb shell "ls -alR /system/lib/ 2>/dev/null" | tee -a $report_name/libraries/lib_permissions.txt 2>/dev/null
echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo ""  | tee -a $report_name/$report_name.txt 2>/dev/null 

echo -e "[-]Extracting system libraries" | tee -a $report_name/$report_name.txt 2>/dev/null 
adb pull system/lib/ $report_name/libraries 2>/dev/null 
echo -e "[-]Done"  | tee -a $report_name/$report_name.txt 2>/dev/null 

echo ""  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$smalline"  | tee -a $report_name/$report_name.txt 2>/dev/null 

}

#++++++++++++++++++++
#Enumarate the Droid
#+++++++++=++++++++++
if [ $1 == '-r' ] || [ $1 == '--report' ] ; then

report_name=$2

#Setup directories
mkdir -p $report_name/libraries/app-lib/ 2>/dev/null 
mkdir -p $report_name/binaries/ 2>/dev/null 
mkdir -p $report_name/apps/system_app/ 2>/dev/null 
mkdir -p $report_name/apps/user_app/app/ 2>/dev/null 
mkdir -p $report_name/file_system/
touch $report_name/$report_name.txt 2>/dev/null 

#Call the necessary functions
logo | tee -a $report_name/$report_name.txt 2>/dev/null 

##############
#Device info
##############
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "Device information and Features" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
device_info 
device_features 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "Device Properties" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$bigline"  | tee -a $report_name/$report_name.txt 2>/dev/null 
device_properties 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "Memory" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
memory

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "Services" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
services  

echo "$bigline"  | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "Networking" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
networking 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "File System" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
filesystem 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "File Permisions" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
file_permissions 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "Environment" | tee -a $report_name/$report_name.txt 2>/dev/null 
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null 
environment 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "Users and Groups" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
user_app_groups 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "System binaries" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
system_binaries 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "Regular apps" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
regular_apps 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "System apps" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
system_apps 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "App libraries" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
app_libraries 

echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "System libraries" | tee -a $report_name/$report_name.txt 2>/dev/null
echo "$bigline" | tee -a $report_name/$report_name.txt 2>/dev/null
system_libraries

fi