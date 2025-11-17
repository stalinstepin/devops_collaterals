#!/bin/bash

# Install Prometheus Node Exporter.
echo "Installing and setting up Prometheus Node Exporter..."
sudo sh /tmp/install_prometheus_node_exporter.sh

# Install Docker.
echo "Installing Docker..."
sudo sh /tmp/install_docker.sh > /dev/null 2>&1
echo "Docker installation successful!"

# Setting up directories and files for Prometheus.
echo "Setting up directory and docker-compose files for Prometheus."
sudo mkdir -p ~/docker_compose_files/prometheus/prometheus-data
sudo cp /tmp/prometheus_* ~/docker_compose_files/prometheus/
sudo mv ~/docker_compose_files/prometheus/prometheus_docker_compose.yaml ~/docker_compose_files/prometheus/docker-compose.yaml
echo "Finished processing file and folder configurations."

# Updating Prometheus Configuration with nodes current private IP.
sudo sh /tmp/update_ip.sh

# Deploying Prometheus.
echo "Deploying Prometheus"
sudo sh /tmp/deploy_prometheus.sh > /dev/null 2>&1
echo 'Prometheus Deployed'
sleep 5 # Allowing sufficient time to finish the process --> DO NOT DELETE.