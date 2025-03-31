#!/bin/bash

# Update the package index
sudo apt update

# Install prerequisite packages
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker's official repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add azureuser to the Docker group
sudo usermod -aG docker azureuser

# Set permissions for Docker socket
sudo chmod 660 /var/run/docker.sock

# Verify Docker installation and permissions
sudo docker --version
ls -l /var/run/docker.sock

# Prompt to restart the shell for group changes to take effect
echo "Installation complete! azureuser has been added to the Docker group. Please restart your shell or log out and log back in for the group changes to take effect."
