#!/bin/bash

curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
sudo systemctl start docker 
sudo usermod -aG docker ubuntu
sudo systemctl restart docker

sudo docker run --rm -dp 80:80 --name nginx-server nginx:1.18