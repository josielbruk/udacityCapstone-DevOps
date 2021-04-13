#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build -t devops-capstone-blue .
# Step 2: 
# List docker images
docker image ls
# Step 3: 
# Run flask app
docker run -d -p 30000:80 devops-capstone-blue

docker save -o Dockerimage.tar devops-capstone-blue