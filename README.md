# selenium
yaml file to deploy selenium grid in docker containers

# Install Docker 
First install docker on all host machines.eg Server 1,2
> curl -SsL https://get.docker.com | sh

# Install and configure docker-compose
Run this command to download the current stable release of Docker Compose:
> sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

Apply executable permissions to the binary:
> sudo chmod +x /usr/local/bin/docker-compose

# Download .yaml file
> wget https://raw.githubusercontent.com/pbushan/selenium/master/servergrid.yaml

# Use docker-compose to get the selenium grid up and running
> sudo docker-compose -f servergrid.yaml up -d

# If you need to bring down the grid use
> sudo docker-compose -f servergrid.yaml down
