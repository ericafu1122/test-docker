#!/bin/bash
set -x
sudo apt-get update && sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

printf "adding docker gpg key"
until curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -; do
    printf '.'
    sleep 2
done

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update && sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

sudo systemctl enable docker

printf "installing compose"
until sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; do
    printf '.'
    sleep 2
done

sudo chmod +x /usr/local/bin/docker-compose
