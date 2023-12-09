#!/bin/sh

echo "Start docker if it is not already running" 
sudo service docker start 

echo "Install Portainer"
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# if [ ! -f ~/.local/zsh_config/docker.zsh ]; then
#     echo "service docker status >/dev/null" >~/.local/zsh_config/docker.zsh
#     echo "if [ \$? -ne 0 ]; then" >>~/.local/zsh_config/docker.zsh
#     echo "  wsl.exe --user root service docker start" >>~/.local/zsh_config/docker.zsh
#     echo "  alias docker='sudo docker'" >>~/.local/zsh_config/docker.zsh
#     echo "fi" >>~/.local/zsh_config/docker.zsh
# fi

if [ ! -f ~/.local/zsh_config/docker.zsh ]; then
    rm ~/.local/zsh_config/docker.zsh
fi
if [ -f /etc/wsl.conf ]; then
    cat /etc/wsl.conf | grep "[boot]"
    if [ $? -ne 0 ]; then
        echo "[boot]" >>/etc/wsl.conf
    fi
else
    echo "[boot]" >/etc/wsl.conf
fi
cat /etc/wsl.conf | grep "command"
if [ $? -ne 0 ]; then
    echo "command = service docker start" >>/etc/wsl.conf
fi
