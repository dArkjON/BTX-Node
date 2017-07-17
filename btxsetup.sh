
#!/bin/bash
# This script will install all required stuff to run a BitCore (BTX) Node.
# BitSend Repo : https://github.com/LIMXTEC/BitCore
# !! THIS SCRIPT NEED TO RUN AS ROOT !!
######################################################################

clear
echo "*********** Welcome to the BitSend (BSD) Setup Script ***********"
echo 'This script will install all required updates & package for Ubuntu 14.04 !'
echo 'Clone & Compile the BTX Wallet also help you on first setup and sync'
echo '****************************************************************************'
sleep 3
echo '*** Step 1/5 ***'
echo '*** Creating 2GB Swapfile ***'
sleep 1
dd if=/dev/zero of=/mnt/mybsdswap.swap bs=2M count=1000
mkswap /mnt/mybtxswap.swap
swapon /mnt/mybtxswap.swap
sleep 1
echo '*** Done 1/5 ***'
sleep 1
echo '*** Step 2/5 ***'
echo '*** Running updates and install required packages ***'
sleep 2
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install build-essential libtool autotools-dev autoconf pkg-config libssl-dev -y
sudo apt-get install libboost-all-dev git npm nodejs nodejs-legacy libminiupnpc-dev redis-server -y
sudo apt-get install software-properties-common -y
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils -y
sudo apt-get install libzmq3-dev -y
add-apt-repository ppa:bitcoin/bitcoin
apt-get update -y
apt-get install libdb4.8-dev libdb4.8++-dev -y
curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh
source ~/.profile
echo '*** Done 2/5 ***'
sleep 1
echo '*** Step 3/5 ***'
echo '*** Cloning and Compiling BitCore Wallet ***'
cd
git clone https://github.com/LIMXTEC/BitCore
cd BitCore
./autogen.sh
./configure
make

cd
cd BitCore/src
strip bitcored
cp bitcored /usr/local/bin

cd

echo '*** Done 3/5 ***'
sleep 2
echo '*** Step 4/5 ***'
echo '*** Configure bitsend.conf and download and import bootstrap file ***'
sleep 2

bitcored
sleep 3

echo -n "Please Enter a STRONG Password or copy & paste the password generated for you above and Hit [ENTER]: "
read usrpas

echo -e "rpcuser=btxnodeservice2387645 \nrpcpassword=$usrpas \nrpcallowip=127.0.0.1 \nserver=1 \nlisten=1 \ndaemon=1 \nlogtimestamps=1 \n" > ~/.bitcore/bitcore.conf
cd .bitcore

#wget https://www.mybitsend.com/bootstrap.tar.gz

#tar -xvzf bootstrap.tar.gz
echo '*** Done 4/5 ***'
sleep 2
echo '*** Step 5/5 ***'
echo '*** Last Server Start also Wallet Sync ***'
echo 'After 1 minute you will see the 'getinfo' output from the RPC Server...'
bitcored
sleep 60
bitcored getinfo
sleep 2
echo 'Have fun with your Node !'
sleep 2
echo '*** Done 5/5 ***'
