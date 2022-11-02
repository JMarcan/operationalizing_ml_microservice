# operationalizing_ml_microservice

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/JMarcan/operationalizing_ml_microservice/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/JMarcan/operationalizing_ml_microservice/tree/main)

# Project summary
The goal of the project was to to operationalize a machine learning microservice for production.<br>
For that, I provisioned the automated pipeline where:
- CI pipeline executes static code analysis, linting, testing, and dockerization
- CD pipeline executes blue-green deployment into AWS EKS Kubernetes Service via Terraform.

The machine learning app itself is pretrained model<br> 
predicting housing prices in Boston based on certain input features<br>
such as average rooms in a home and data about highway access, and so on.
![predicting_housing_prices](assets/ml_predicting_housing_prices.png)

## Prerequisites
The setup has the following prerequisites:
- CircleCI account integrated with the code repository
- DockerHub account, with repository name configured configured in CircleCI environment variables 
- AWS account and corresponding IAM user with deployment rights, with secret keys configured in CircleCI environment variables 
- S3 bucket to keep the terraform state, configured in 'config/dev_backend.tfvars'
- DynamoDB table to keep the terraform lock, configured in 'config/dev_backend.tfvars'

## Pipeline screens

![cicd_pipeline](assets/CICD_Pipeline.png)

![tests_run](assets/tests_run.png)

![publish_docker](assets/tests_run.png)

![terraform_infra_plan](assets/terraform_infra_plan.png)

![aws_eks_cluster](assets/aws_eks_cluster.png)

![homepage](assets/app_webpage.png)

# Running the app locally on linux
The following steps describes how to run the app on linux.

## Setting up the environment
1. Create a python virtual environment and activate it
- `python3 -m venv ~/.ml_microservice_env`
- `source ~/.ml_microservice_env/bin/activate`
2. Run `make install` to install dependencies
3. Install other libraries (if not already installed)
- Docker
- Hadolint
- Kubernetes (Minikube)

You can verify the installation of Docker and Kubernetes (Minikube) 
by checking the version of the libary
- `docker --version`
- `kubectl version`


## Running the app

1. Build and start docker container: 
Run `./run_docker.sh`<br>
Verify its proper deployment by running `/.make_prediction` from separate command line.

    
2. Run it in Kubernetes: 
To start a local cluster, type the terminal command: `minikube start`<br>
After minikube starts, a cluster should be running locally.<br>
You can check that you have one cluster running by typing `kubectl config view`<br>
where you should see at least one cluster with a certificate-authority and server.<br><br>
Then deploy the the app on kubernetes cluster by running `./run_kubernetes.sh`<br><br>
Initially, your pod may be in the process of being created, <br>
as indicated by STATUS: ContainerCreating, but you just have to wait a few minutes until the pod is ready,<br>
then you can run the script again.<br><br>
You can check on your pod’s status with a call to `kubectl get pod`<br> 
and you should see the status change to Running. Then you can run again `./run_kubernetes.sh`.<br><br>
Verify its proper deployment by running `/.make_prediction` from separate command line.<br>
![prediction_output](assets/prediction_output.png)