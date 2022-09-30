#!/bin/sh

# This is the Server install script.
echo "AlphaX KawPoW Server install script for Ubuntu Server 20.04."
echo "Please do NOT run as root, run as the pool user!"
echo "If it not exist, create the pool user!"

sleep 2

echo "Installing... Please wait!"

sleep 2

sudo rm -rf /usr/lib/node_modules
sudo rm -rf node_modules
sudo apt remove --purge -y nodejs
sudo rm /etc/apt/sources.list.d/*

sudo apt update
sudo apt upgrade -y

sudo apt install -y apt-transport-https software-properties-common build-essential autoconf pkg-config make gcc g++ screen wget curl ntp fail2ban

sudo add-apt-repository -y ppa:chris-lea/redis-server
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt update
sudo apt install -y libdb-dev libdb++-dev libssl-dev libboost-all-dev libminiupnpc-dev libtool autotools-dev
sudo apt install -y sudo git nodejs nginx certbot python3-certbot-nginx redis-server unzip htop

sleep 3

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sleep 2
sudo systemctl enable redis-server
sudo systemctl start redis-server
sleep 2
sudo systemctl enable ntp
sudo systemctl start ntp

sudo rm -rf ~/.nvm
sudo rm -rf ~/.npm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile
source ~/.bashrc
sudo chown -R $USER:$GROUP ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install v14.20.1
nvm use v14.20.1

npm update -g
npm install -g npm@8.19.2
npm install -g pm2@5.2.0

git config --global http.https://gopkg.in.followRedirects true
git clone https://github.com/AlphaX-Projects/alphax-kawpow-server
chmod -R +x alphax-kawpow-server/
cd alphax-kawpow-server

npm install
npm update
npm audit fix
npm install sha3
npm install logger
npm install bignum

echo ""
echo "KawPoW Server Installed!"
echo ""

exit 0
