#!/bin/zsh

# .\px.exe --listen=0.0.0.0 --allow=*.*.*.* --noproxy=127.0.0.1,localhost --proxy=proxy.host:8080 --save
# .\px.exe --install
# .\px.exe &


WINHOST=$(ip route show | grep -i default | awk '{ print $3 }')

export HTTP_PROXY="http://$WINHOST:3128"
export HTTPS_PROXY="http://$WINHOST:3128"
export NO_PROXY="127.0.0.1,localhost,$WINHOST"

