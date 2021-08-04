#!/bin/bash
MYIP=$(wget -qO- ipv4.icanhazip.com)
MYIP2="s/xxxxxxxxx/$MYIP/g";
wget -q -O ipreg http://ip.untadot.asia:81/ipreg.txt
if ! grep -w -q $MYIP ipreg; then
echo -e "\e[0;31m # NAK DAFTAR IP ? CONTACT SAYA @UntaDotMY DI TELEGRAM # \e[0;0m"
rm -f ipreg
  exit
  fi
rm -f ipreg
if [ "${EUID}" -ne 0 ]; then
  echo "You need to run this script as root"
  exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
  echo "OpenVZ is not supported"
  exit 1
fi

if [[ ! -e /root/Version ]]; then
echo "1" > /root/Version
fi

Version=$(wget -qO- --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/UntaDotMy/premm/main/Version)
CVersion=$(cat /root/Version)

if [[ $CVersion -eq 1 ]]; then
clear
# install OHP
cd
wget https://github.com/lfasmpao/open-http-puncher/releases/download/0.1/ohpserver-linux32.zip
unzip ohpserver-linux32.zip
mv ohpserver /usr/bin/ohp
rm -f ohpserver-linux32.zip
chmod +x /usr/bin/ohp
sed -i '$ i\screen -dmS OHP ohp -port 8087 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:1194' /etc/rc.local
screen -dmS OHP ohp -port 8087 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:1194

#Fix OHP in v2
cat > /etc/openvpn/client-OHP.ovpn <<-END
client
dev tun
persist-tun
proto tcp
setenv FRIENDLY_NAME OHP
remote "bug.com"
port 443
http-proxy xxxxxxxxx 8087
http-proxy-option VERSION 1.1
http-proxy-option CUSTOM-HEADER Host bug.com
http-proxy-option CUSTOM-HEADER X-Forward-Host bug.com
http-proxy-option CUSTOM-HEADER X-Forwarded-For bug.com
http-proxy-option CUSTOM-HEADER Referrer bug.com
persist-remote-ip
resolv-retry infinite
connect-retry 0 1
remote-cert-tls server
nobind
reneg-sec 0
keysize 0
rcvbuf 0
sndbuf 0
verb 2
comp-lzo
auth none
auth-nocache
cipher none
setenv CLIENT_CERT 0
auth-user-pass
END

sed -i $MYIP2 /etc/openvpn/client-OHP.ovpn;

# masukkan certificatenya ke dalam config client OHP
echo '<ca>' >> /etc/openvpn/client-OHP.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-OHP.ovpn
echo '</ca>' >> /etc/openvpn/client-OHP.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( OHP )
cp /etc/openvpn/client-OHP.ovpn /home/vps/public_html/client-OHP.ovpn

fi
if [[ $CVersion -ge $Version ]]; then
clear
echo " No new update "
echo " Your Script Version : $CVersion "
echo " Current Script Version : $Version "
rm -f update.sh
else
clear
echo " Got Update ! "
sleep 2
echo " Your Script Version : $CVersion "
sleep 2
echo " Current Script Version : $Version "
sleep 2
echo -ne '>>>                       [20%]\r'
cd /usr/bin
wget -q -O menu "https://raw.githubusercontent.com/UntaDotMy/premm/main/menu.sh"
wget -q -O m-sshvpn "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-sshvpn.sh"
wget -q -O m-wg "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-wg.sh"
wget -q -O m-ssr "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-ssr.sh"
wget -q -O m-s "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-s.sh"
wget -q -O m-vmess "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-vmess.sh"
wget -q -O m-vless "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-vless.sh"
wget -q -O m-tr "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-tr.sh"
wget -q -O m-sys "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-sys.sh"
wget -q -O usernew "https://raw.githubusercontent.com/UntaDotMy/premm/main/usernew.sh"
wget -q -O trial "https://raw.githubusercontent.com/UntaDotMy/premm/main/trial.sh"
wget -q -O hapus "https://raw.githubusercontent.com/UntaDotMy/premm/main/hapus.sh"
wget -q -O member "https://raw.githubusercontent.com/UntaDotMy/premm/main/member.sh"
wget -q -O delete "https://raw.githubusercontent.com/UntaDotMy/premm/main/delete.sh"
wget -q -O cek "https://raw.githubusercontent.com/UntaDotMy/premm/main/cek.sh"
wget -q -O restart "https://raw.githubusercontent.com/UntaDotMy/premm/main/restart.sh"
wget -q -O renew "https://raw.githubusercontent.com/UntaDotMy/premm/main/renew.sh"
wget -q -O autokill "https://raw.githubusercontent.com/UntaDotMy/premm/main/autokill.sh"
wget -q -O ceklim "https://raw.githubusercontent.com/UntaDotMy/premm/main/ceklim.sh"
wget -q -O tendang "https://raw.githubusercontent.com/UntaDotMy/premm/main/tendang.sh"
wget -q -O change-port "https://raw.githubusercontent.com/UntaDotMy/premm/main/change.sh"
wget -q -O port-ovpn "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-ovpn.sh"
wget -q -O port-dropbear "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-dropbear.sh"
wget -q -O port-ssl "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-ssl.sh"
wget -q -O port-wg "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-wg.sh"
wget -q -O port-tr "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-tr.sh"
wget -q -O port-ohp "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-ohp.sh"
wget -q -O port-squid "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-squid.sh"
wget -q -O port-ws "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-ws.sh"
wget -q -O port-vless "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-vless.sh"
wget -q -O port-xs "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-xs.sh"
wget -q -O port-xless "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-xless.sh"
wget -q -O port-xtls "https://raw.githubusercontent.com/UntaDotMy/premm/main/port-xtls.sh"
wget -q -O wbmn "https://raw.githubusercontent.com/UntaDotMy/premm/main/webmin.sh"
wget -q -O xp "https://raw.githubusercontent.com/UntaDotMy/premm/main/xp.sh"
wget -q -O m-xmess "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-xmess.sh"
wget -q -O m-xless "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-xless.sh"
wget -q -O m-xtls "https://raw.githubusercontent.com/UntaDotMy/premm/main/m-xtls.sh"
wget -q -O user-password "https://raw.githubusercontent.com/UntaDotMy/premm/main/user-password"
wget -q -O user-unlock "https://raw.githubusercontent.com/UntaDotMy/premm/main/user-unlock"
wget -q -O add-ws "https://raw.githubusercontent.com/UntaDotMy/premm/main/add-ws.sh"
wget -q -O add-vless "https://raw.githubusercontent.com/UntaDotMy/premm/main/add-vless.sh"
wget -q -O add-xs "https://raw.githubusercontent.com/UntaDotMy/premm/main/add-xs.sh"
wget -q -O add-xless "https://raw.githubusercontent.com/UntaDotMy/premm/main/add-xless.sh"
wget -q -O add-xtls "https://raw.githubusercontent.com/UntaDotMy/premm/main/add-xtls.sh"
wget -q -O add-tr "https://raw.githubusercontent.com/UntaDotMy/premm/main/add-tr.sh"
wget -q -O del-ws "https://raw.githubusercontent.com/UntaDotMy/premm/main/del-ws.sh"
wget -q -O del-vless "https://raw.githubusercontent.com/UntaDotMy/premm/main/del-vless.sh"
wget -q -O del-xs "https://raw.githubusercontent.com/UntaDotMy/premm/main/del-xs.sh"
wget -q -O del-xless "https://raw.githubusercontent.com/UntaDotMy/premm/main/del-xless.sh"
wget -q -O del-xtls "https://raw.githubusercontent.com/UntaDotMy/premm/main/del-xtls.sh"
wget -q -O del-tr "https://raw.githubusercontent.com/UntaDotMy/premm/main/del-tr.sh"
wget -q -O cek-ws "https://raw.githubusercontent.com/UntaDotMy/premm/main/cek-ws.sh"
wget -q -O cek-vless "https://raw.githubusercontent.com/UntaDotMy/premm/main/cek-vless.sh"
wget -q -O cek-xs "https://raw.githubusercontent.com/UntaDotMy/premm/main/cek-xs.sh"
wget -q -O cek-xless "https://raw.githubusercontent.com/UntaDotMy/premm/main/cek-xless.sh"
wget -q -O cek-xtls "https://raw.githubusercontent.com/UntaDotMy/premm/main/cek-xtls.sh"
wget -q -O cek-tr "https://raw.githubusercontent.com/UntaDotMy/premm/main/cek-tr.sh"
wget -q -O renew-ws "https://raw.githubusercontent.com/UntaDotMy/premm/main/renew-ws.sh"
wget -q -O renew-vless "https://raw.githubusercontent.com/UntaDotMy/premm/main/renew-vless.sh"
wget -q -O renew-xs "https://raw.githubusercontent.com/UntaDotMy/premm/main/renew-xs.sh"
wget -q -O renew-xless "https://raw.githubusercontent.com/UntaDotMy/premm/main/renew-xless.sh"
wget -q -O renew-xtless "https://raw.githubusercontent.com/UntaDotMy/premm/main/renew-xtls.sh"
wget -q -O renew-tr "https://raw.githubusercontent.com/UntaDotMy/premm/main/renew-tr.sh"
wget -q -O certv2ray "https://raw.githubusercontent.com/UntaDotMy/premm/main/cert.sh"
chmod +x menu
chmod +x m-sshvpn
chmod +x m-wg
chmod +x m-ssr
chmod +x m-s
chmod +x m-vmess
chmod +x m-vless
chmod +x m-xmess
chmod +x m-xless
chmod +x m-xtls
chmod +x m-tr
chmod +x m-sys
chmod +x usernew
chmod +x trial
chmod +x hapus
chmod +x member
chmod +x delete
chmod +x cek
chmod +x restart
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x renew
chmod +x change-port
chmod +x port-ovpn
chmod +x port-ssl
chmod +x port-wg
chmod +x port-tr
chmod +x port-squid
chmod +x port-ws
chmod +x port-vless
chmod +x port-xs
chmod +x port-xless
chmod +x port-xtls
chmod +x port-dropbear
chmod +x wbmn
chmod +x xp
chmod +x user-password
chmod +x user-unlock
chmod +x add-ws
chmod +x add-vless
chmod +x add-xs
chmod +x add-xless
chmod +x add-xtls
chmod +x add-tr
chmod +x del-ws
chmod +x del-vless
chmod +x del-xs
chmod +x del-xless
chmod +x del-xtls
chmod +x del-tr
chmod +x cek-ws
chmod +x cek-vless
chmod +x cek-xs
chmod +x cek-xless
chmod +x cek-xtls
chmod +x cek-tr
chmod +x renew-ws
chmod +x renew-vless
chmod +x renew-xs
chmod +x renew-xless
chmod +x renew-xtls
chmod +x renew-tr
chmod +x certv2ray
cd
sleep 2
echo -ne '>>>>>>>                   [40%]\r'
#some task here
sleep 2
echo -ne '>>>>>>>>>>>>>>            [60%]\r'
#some task here
sleep 2
echo -ne '>>>>>>>>>>>>>>>>>>>>>>>   [80%]\r'
echo "$Version" > /root/Version
sleep 2
echo -ne '>>>>>>>>>>>>>>>>>>>>>>>>>>[100%]\r'
rm -f update.sh
echo -ne '\n'
fi