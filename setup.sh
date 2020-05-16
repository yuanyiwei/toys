echo Please Input Your Subscribe Link:
read url

SH_PROFILE="$HOME/.zshrc"

rm -f clash.sh

echo 'export all_proxy=socks5://127.0.0.1:7891' > clashrupdate.sh
echo wget -O $HOME/.config/clash/config.yaml $url>>clashrupdate.sh
echo 'unset all_proxy' >> clashrupdate.sh

echo 'nohup $HOME/.config/clash/clashr-linux-amd64 &' > clashr.sh

echo alias clash='"~/.config/clash/clashr.sh"'>>$SH_PROFILE
echo alias clashupdate='"~/.config/clash/clashrupdate.sh"'>>$SH_PROFILE
echo alias proxy='"export all_proxy=socks5://127.0.0.1:7891"'>>$SH_PROFILE
echo alias unproxy='"unset all_proxy"'>>$SH_PROFILE
echo alias ip='"curl ipinfo.io"'>>$SH_PROFILE

mkdir ~/.config/clash
cp *  ~/.config/clash

echo You Can Start Clash with command '"clash"'
echo You Can Start Terminal Proxy with command '"proxy"'
echo You Can Stop Terminal Proxy with command '"unproxy"'

chmod +x ~/.config/clash/*
rm -rf clash.sh
rm -rf config.yaml
exec $SHELL
