#!/bin/bash
echo "############################################ Bringing up build environment."
docker-compose --project-name chronopolis up -d
echo "############################################ Build environment running."
