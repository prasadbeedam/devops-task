Jenkins CI/CD Pipeline for Logo Server
📌 Overview

This repository includes a Jenkins pipeline that automates the build, test, and deployment of the Logo Server application.

The pipeline performs the following steps:

Checkout source code from GitHub

Read app version from package.json

Build and tag a Docker image

Run tests (optional)

Push the image to Docker Hub

Update the Kubernetes manifest.yaml with the new image version

Deploy the updated app to AWS EKS

🏗️ Pipeline Stages
🔹 1. Checkout

Pulls the source code from the dev branch of the GitHub repo:

https://github.com/prasadbeedam/devops-task.git

🔹 2. Read Version

Reads the version field from package.json.

Constructs a Docker image tag:

prasadyadav99/logo-server:<version>

🔹 3. Build Docker Image

Builds a Docker image for the application:

docker build -t prasadyadav99/logo-server:<version> .

🔹 4. Test

(Optional) Run application tests.
Currently just logs a message, but can be extended with:

npm test

🔹 5. Push Docker Image

Logs in to Docker Hub using Jenkins credentials (dockerhub) and pushes the image.

🔹 6. Update Kubernetes Manifest

Updates the manifest.yaml file with the new image tag:

image: prasadyadav99/logo-server:<version>

🔹 7. Deploy to Kubernetes

Uses AWS credentials (aws-creds) to authenticate.

Detects the EKS cluster dynamically.

Updates kubeconfig for the cluster.

Applies the updated manifest.yaml using kubectl.

⚙️ Jenkins Setup
🔑 Credentials Needed

Docker Hub:

ID: dockerhub

Type: Username/Password

AWS:

ID: aws-creds

Type: AWS Credentials (Access key + Secret key)

🌍 Environment Variables

Configured inside the Jenkinsfile:

DOCKERHUB_USER = "prasadyadav99"

IMAGE_NAME = "logo-server"

KUBECONFIG = "/var/lib/jenkins/.kube/config"

🚀 How to Run

Create a Jenkins pipeline job.

Point it to this repository.

Ensure Docker, kubectl, and AWS CLI are installed on the Jenkins agent.

Run the pipeline → it will build, push, and deploy the app.

📜 Example Output

Build logs will show:

📦 Application version: 1.0.0
🐳 Building Docker image: prasadyadav99/logo-server:1.0.0
✅ Docker image pushed: prasadyadav99/logo-server:1.0.0
🌐 Using EKS cluster: my-cluster


The updated app will be deployed to your EKS cluster automatically.