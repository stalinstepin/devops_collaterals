#!/bin/bash

echo "Creating systemd service to update Prometheus Configurations with current node IP for Node Exporter scrape Job!"
sudo cp /tmp/update_ip.service /usr/lib/systemd/system/update-ip.service
sleep 15
sudo chmod +x /tmp/update_prometheus_config.sh
sudo cp /tmp/update_prometheus_config.sh /usr/local/bin/update-prometheus-config.sh
sudo systemctl daemon-reload
sudo systemctl enable --now update-ip.service
sudo systemctl status update-ip.service