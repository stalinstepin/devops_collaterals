#!/bin/bash
# Script to update the IP address of the Prometheus Node Exporter in the Prometheus_config.yaml file. 

export PROM_CONFIG=/home/ubuntu/docker_compose_files/prometheus/prometheus_config.yaml
export SOURCE=$(cat ${PROM_CONFIG} | grep -A4 "job_name: node" | grep targets | awk -F ':' '{print $2}' | awk -F "'" '{print $2}')
export TARGET=$(hostname -i)
sudo sed -i "s/${SOURCE}/${TARGET}/g" $PROM_CONFIG