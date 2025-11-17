#!/bin/sh

sudo newgrp docker
(cd  /home/ubuntu/docker_compose_files/prometheus && sudo docker compose up -d)