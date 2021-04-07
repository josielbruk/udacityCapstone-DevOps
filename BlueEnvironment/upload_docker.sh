#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath="josielbr/devops-capstone-blue"

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker tag devops-capstone-blue $dockerpath
docker login --username josielbr -p $DOCKER_PWD
# Step 3:
# Push image to a docker repository
docker push josielbr/$dockerpath