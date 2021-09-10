#!/usr/bin/env bash

proxy="http://192.168.20.10:8080"
ip="192.168.20.11"

# Remove default gateway
ip route del default

# Get the proxy certificate and install it 
curl -v --proxy ${proxy} -o cert.pem http://mitm.it/cert/pem
openssl x509 -in cert.pem -inform PEM -out /usr/local/share/ca-certificates/cert.crt
update-ca-certificates

# TFE installation
cp /vagrant/config/replicated.conf /etc/replicated.conf
curl -o install.sh --proxy ${proxy} https://install.terraform.io/ptfe/stable
bash ./install.sh http-proxy=${proxy} private-address=${ip} public-address=${ip}
usermod -aG docker vagrant
