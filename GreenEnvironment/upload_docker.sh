#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath="josielbr/devops-capstone-green"

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker tag devops-capstone-green $dockerpath
docker login --username josielbr
# Step 3:
# Push image to a docker repository
docker push $dockerpath