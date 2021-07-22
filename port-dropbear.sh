#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipv4.icanhazip.com)
wget -q -O ipreg http://ip.untadot.asia:81/ipreg.txt
if ! grep -w -q $MYIP ipreg; then
echo -e "\e[0;31m # NAK DAFTAR IP ? CONTACT SAYA @UntaDotMY DI TELEGRAM # \e[0;0m"
rm -f ipreg
  exit
  fi
rm -f ipreg
clear
db="$(cat /etc/default/dropbear | grep -i DROPBEAR_PORT= | cut -d= -f2)"
db2="$(cat /etc/default/dropbear | grep -i DROPBEAR_EXTRA_ARGS= | cut -d= -f2)"
echo -e "======================================"
echo -e ""
echo -e "     [1]  Change Port $db"
echo -e "     [2]  Change Port $db2"
echo -e "     [x]  Exit"
echo -e "======================================"
echo -e ""
read -p "     Select From Options [1 or x] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Dropbear: " dbp
if [ -z $dbp ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $dbp)
if [[ -z $cek ]]; then
sed -i 's/$db/$dbp/g' /etc/default/dropbear
sed -i "s/$db/$dbp/g" /root/log-install.txt
/etc/init.d/dropbear restart > /dev/null
echo -e "\e[032;1mPort $dpb modified successfully\e[0m"
else
echo "Port $dbp is used"
fi
;;
2)
read -p "New Port Dropbear: " dbp
if [ -z $dbp ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $dbp)
if [[ -z $cek ]]; then
sed -i 's/$db/$dbp/g' /etc/default/dropbear
sed -i "s/$db/$dbp/g" /root/log-install.txt
/etc/init.d/dropbear restart > /dev/null
echo -e "\e[032;1mPort $dpb modified successfully\e[0m"
else
echo "Port $dbp is used"
fi
;;
x)
exit
menu
;;
*)
echo "Please enter an correct number"
;;
esac

