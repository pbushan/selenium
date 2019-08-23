#!/bin/sh

set -eu

# Install Docker
sudo apt remove --yes docker docker-engine docker.io \
    && sudo apt update \
    && curl -SsL https://get.docker.com | sh \
    && printf '\nDocker installed successfully\n\n'

&& printf 'Waiting for Docker to start...\n\n'
&& sleep 10
# Get out of using sudo each time
&& sudo usermod -aG docker ubuntu \

# Docker Compose
&& sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && sudo chmod +x /usr/local/bin/docker-compose \
    && printf '\nDocker Compose installed successfully\n\n'
# Download prometheus.yml
&& sudo curl https://raw.githubusercontent.com/pbushan/selenium/master/prometheus.yml > prometheus.yml\
# Install Selenium Grid
&& curl https://raw.githubusercontent.com/pbushan/selenium/master/servergrid.yaml > servergrid.yaml \
&& sudo docker-compose -f servergrid.yaml up -d \

#Scale the chrome nodes per instance
&& sudo docker-compose -f servergrid.yaml scale chrome=10
