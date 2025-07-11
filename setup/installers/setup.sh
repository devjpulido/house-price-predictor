#!/bin/bash

# Variables
DOCKER_GROUP="docker"
DOCKER_GPG_URL="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_REPO_URL="https://download.docker.com/linux/ubuntu"
DOCKER_KEYRING="/etc/apt/keyrings/docker.asc"
DOCKER_LIST="/etc/apt/sources.list.d/docker.list"
DOCKER_VERSION="latest"

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or use sudo."
  exit 1
fi

# Ensure required dependencies are installed
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL $DOCKER_GPG_URL -o $DOCKER_KEYRING
sudo chmod a+r $DOCKER_KEYRING

# Add the Docker repository
if ! grep -q "$DOCKER_REPO_URL" $DOCKER_LIST 2>/dev/null; then
  echo "deb [arch=$(dpkg --print-architecture) signed-by=$DOCKER_KEYRING] $DOCKER_REPO_URL $(. /etc/os-release && echo \"${UBUNTU_CODENAME:-$VERSION_CODENAME}\") stable" | sudo tee $DOCKER_LIST > /dev/null
fi
sudo apt-get update

# Install Docker packages
sudo apt-get install -y docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io docker-buildx-plugin docker-compose-plugin

# Create Docker group if it doesn't exist
if ! getent group $DOCKER_GROUP > /dev/null; then
  sudo groupadd $DOCKER_GROUP
fi

# Add the current user to the Docker group
if ! groups $USER | grep -q $DOCKER_GROUP; then
  sudo usermod -aG $DOCKER_GROUP $USER
fi

# Adjust permissions for Docker directory
if [ -d "/home/$USER/.docker" ]; then
  sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
  sudo chmod g+rwx "$HOME/.docker" -R
fi

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Print completion message
echo "Docker installation and setup completed successfully. Please log out and log back in for group changes to take effect."

# Print Docker version
docker --version
