[![CircleCI](https://circleci.com/gh/circleci/circleci-docs.svg?style=svg)](https://app.circleci.com/pipelines/github/josielbruk/udacityCapstone-DevOps)

# Project Overview
Capstone project for [Udacity's AWS Cloud DevOps course](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991). It uses the Blue Green methodology to take traffic to move from one docker instance to the other.

# Objectives
* Working in AWS
* Using Jenkins to implement Continuous Integration and Continuous Deployment
* Building pipelines
* Working with CloudFormation to deploy clusters
* Building Kubernetes clusters
* Building Docker containers in pipelines

# Tools Used
* Git & GitHub
* CircleCi
* AWS & AWS-CLI
* Nginx
* pip3
* Hadolint
* Docker & Docker-Hub Registry
* Kubernetes CLI (kubectl)
* EKS
* CloudFormation
* BASH

# Procedure to create the cluster and workers


Both, cluster and the worker node group creation are managed by cloudformation configuration files: scripts/cluster.yml and scripts/nodes-workers.yml

## Commands to create the Cluster and Workers node:

Build AWS Cluster

`aws cloudformation create-stack --stack-name UdacityCapstoneJosiel --template-body file://cluster.yml --parameters file://cluster-parameters.json --capabilities CAPABILITY_IAM`

![picture alt](https://github.com/josielbruk/udacityCapstone-DevOps/blob/master/SupportFiles/01%20-%20Cloudformation-UdacityCapstoneJosiel-stack.png)

Build Workers on AWS

`aws cloudformation create-stack --stack-name UdacityCapstoneJosiel-workers --template-body file://nodes-workers.yml --parameters file://nodes-workers-parameters.json --capabilities CAPABILITY_IAM`

![picture alt](https://github.com/josielbruk/udacityCapstone-DevOps/blob/master/SupportFiles/02%20-%20Cloudformation-UdacityCapstoneJosiel-workers-stack.png)

Configure kubectl with the newly created Cluster

`aws eks --region eu-west-2 update-kubeconfig --name UdacityCapstoneJosiel-Cluster`

Next step is the Cluster authentication that is done with the file [scripts/aws-auth.yml](https://github.com/josielbruk/udacityCapstone-DevOps/blob/master/scripts/aws-auth.yml)

# Pipeline

![picture alt](https://github.com/josielbruk/udacityCapstone-DevOps/blob/master/SupportFiles/04%20-%20Circleci%20Pipeline.png)

Assuming you have already setup the your project on github and on the circleci and this with your Environment Variables: 
* AWS_ACCESS_KEY_ID
* AWS_DEFAULT_REGION
* AWS_SECRET_ACCESS_KEY
* DOCKER_PWD
* DOCKER_USERNAME	

on the [.circleci/config.yml](https://github.com/josielbruk/udacityCapstone-DevOps/blob/master/.circleci/config.yml) there is an environment variable: MoveToProduction, when set to false the latest Blue docker image [devops-capstone-blue]( https://hub.docker.com/repository/docker/josielbr/devops-capstone-blue) is deployed. When set to true the latest Green docker image [devops-capstone-green](https://hub.docker.com/repository/docker/josielbr/devops-capstone-green) is deployed.

Therefore every commit on Github will cause the pipeline to update the docker image and deploy it to AWS.
