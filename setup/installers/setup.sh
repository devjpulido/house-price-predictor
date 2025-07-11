#!/bin/bash

# Variables
DOCKER_GROUP="docker"
DOCKER_GPG_URL="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_REPO_URL="https://download.docker.com/linux/ubuntu"
DOCKER_KEYRING="/etc/apt/keyrings/docker.asc"
DOCKER_LIST="/etc/apt/sources.list.d/docker.list"
DOCKER_VERSION="latest"

# 1. Set up Docker's apt repository.

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL $DOCKER_GPG_URL -o $DOCKER_KEYRING
sudo chmod a+r $DOCKER_KEYRING

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=$DOCKER_KEYRING] $DOCKER_REPO_URL \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee $DOCKER_LIST > /dev/null
sudo apt-get update

# 2. Install the Docker packages.
sudo apt-get install -y docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io docker-buildx-plugin docker-compose-plugin

# 3. Manage Docker as a non-root user
sudo groupadd $DOCKER_GROUP

# Add your user to the docker group.
sudo usermod -aG $DOCKER_GROUP $USER

# Adjust permissions for Docker directory
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

# Print completion message
echo "Docker installation and setup completed successfully."

# Print Docker version
docker --version
