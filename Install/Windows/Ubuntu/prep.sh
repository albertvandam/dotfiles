#!/bin/sh

echo "Preparing installation"

if [ ! -f /etc/apt/sources.list.d/shells:zsh-users:zsh-completions.list ]; then
    echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-completions/xUbuntu_22.04/ /' | tee /etc/apt/sources.list.d/shells:zsh-users:zsh-completions.list
    curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/xUbuntu_22.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_zsh-users_zsh-completions.gpg > /dev/null
fi

add-apt-repository -y ppa:jonathonf/vim
add-apt-repository -y universe
apt update
apt-get -y install zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions unzip gnupg ca-certificates bat btop direnv zoxide vim

if [ ! -d /etc/apt/keyrings ]; then
    install -m 0755 -d /etc/apt/keyrings
fi

if [ ! -f /etc/apt/sources.list.d/zulu.list ]; then
    curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
    echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
fi

if [ ! -f /etc/apt/sources.list.d/nodesource.list ]; then
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    NODE_MAJOR=20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
fi    

if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg
fi

# Add the repository to Apt sources:
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

apt update
apt-get install -y zulu17-jdk nodejs docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

apt-get -y upgrade

cd /tmp
wget https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-musl_1.0.0_amd64.deb
dpkg -i lsd-musl_1.0.0_amd64.deb
rm lsd-musl_1.0.0_amd64.deb
wget https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb
dpkg -i git-delta_0.16.5_amd64.deb
rm git-delta_0.16.5_amd64.deb
wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb

if [ -f /etc/wsl.conf ]; then
    /bin/cp /etc/wsl.conf /etc/wsl.conf.bak
fi
echo "[boot]" >/etc/wsl.conf
echo "systemd = true" >>/etc/wsl.conf
echo "" >>/etc/wsl.conf
echo "[automount]" >>/etc/wsl.conf
echo "options = "metadata"" >>/etc/wsl.conf
echo "" >>/etc/wsl.conf
