#!/bin/bash
# 1. Järjestelmän päivitys ja tarvittavat työkalut
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl sudo git ca-certificates

# 2. Docker asennus
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 3. Docker palveluiden aktivointi
sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service

# 4. Asennuksen tarkistus
sudo systemctl is-active docker

# 5. Käyttäjäoikeudet
sudo groupadd -f docker
sudo usermod -aG docker $USER
