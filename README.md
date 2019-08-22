# Scalable selenium grid
Instructions to configure scalable selenium grid using docker-compose

# For fresh Installation only (On all hosts)
## Install Docker 
First install docker on all host machines.eg Server 1,2
> curl -SsL https://get.docker.com | sh

Then add the ubuntu user to the docker group, so we don’t need to use sudo everytime we use the docker command
> sudo usermod -aG docker ubuntu

## Install and configure docker-compose
Run this command to download the current stable release of Docker Compose:
> sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

Apply executable permissions to the binary:
> sudo chmod +x /usr/local/bin/docker-compose

# On worker hosts only

## Download .yaml file
> curl https://raw.githubusercontent.com/pbushan/selenium/master/servergrid.yaml > servergrid.yaml

## Use docker-compose to get the selenium grid up and running
> sudo docker-compose -f servergrid.yaml up -d

## Use docker-compose to scale the grid nodes
for example if you want to scale the number of chrome nodes to `5` then use
> sudo docker-compose -f servergrid.yaml scale chrome=5

## To check status of the grid use
> sudo docker-compose -f servergrid.yaml ps

## If you need to bring down the grid use
> sudo docker-compose -f servergrid.yaml down

# On nginx host only (Will refer to this as manager)

## Download .yaml file
> curl https://raw.githubusercontent.com/pbushan/selenium/master/nginx.yaml > nginx.yaml

## Download and edit nginx configuration file
> curl https://raw.githubusercontent.com/pbushan/selenium/master/nginx.conf > nginx.conf
Use nano editor to change the servername and ports for each server that needs load balancing

## Use docker-compose to get the nginx container up and running
> sudo docker-compose -f nginx.yaml up -d


# To monitor host resource utilization
``` echo "CPU `LC_ALL=C top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'`% RAM `free -m | awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }'` HDD `df -h / | awk '/\// {print $(NF-1)}'`" ```
