#!/bin/bash
# Download Prometheus Node Exporter:
echo "Downloading and installing Prometheus Node Exporter..."
(
  cd /tmp && \
  wget https://github.com/prometheus/node_exporter/releases/download/v1.10.2/node_exporter-1.10.2.linux-amd64.tar.gz \
    -O /tmp/node_exporter-1.10.2.linux-amd64.tar.gz && \
  tar xvfz node_exporter-1.10.2.linux-amd64.tar.gz && \
  cd node_exporter-1.10.2.linux-amd64 && \
  sudo mv node_exporter /usr/local/bin/node_exporter
)

# Copying Prometheus Node Exporter Service file:
sudo mv /tmp/node_exporter.service /usr/lib/systemd/system/node-exporter.service
sudo systemctl daemon-reload
sudo systemctl enable node-exporter
sudo systemctl start node-exporter