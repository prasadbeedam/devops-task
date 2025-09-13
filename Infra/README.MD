Logo Server on AWS EKS
🔎 Overview

This project sets up the Logo Server on an AWS EKS cluster.
The goal is to run the app in a secure, scalable way using Kubernetes, while exposing it to the internet through an ingress controller.

The app is available here: 👉 https://logo-server-dev.prasadbeedam.shop/

🏗️ Architecture

![alt text](infra.drawio-1.svg)

Here’s the breakdown:

VPC → Split into public and private subnets

Bastion Host → Jump box for secure access into private subnets

EKS Cluster → Runs our Kubernetes workloads (pods, services, ingress)

Ingress Controller → Handles incoming traffic from the internet and forwards it to the app

Traffic flow:
User → Domain (Route53) → Ingress Controller → Service → Pod

🚀 How it Works

A DevOps engineer connects through the bastion host (instead of exposing the cluster directly).

The app is deployed into the EKS cluster inside private subnets.

Ingress Controller listens for traffic from the internet and routes requests to Kubernetes services.

Requests hit the pods (Logo Server app).

⚙️ Deployment Steps (High-Level)

VPC & Subnets

Create public and private subnets across two AZs (for HA).

EKS Cluster

Launch the cluster in private subnets.

Configure worker nodes and security groups.

Bastion Host

Deploy a small EC2 instance in the public subnet for SSH access.

Restrict access to trusted IPs.

Ingress Controller

Deploy NGINX or ALB ingress controller.

Point the domain (Route53) to the ingress.

App Deployment

Apply Kubernetes manifests (Deployment, Service, Ingress).

Verify app is up and running.

🔐 Security Highlights

No direct internet access to EKS nodes.

Bastion host is the only entry point for SSH.

Ingress handles SSL and routes requests safely.

Security groups + IAM roles restrict access at every layer.

🛠️ Stack

AWS → VPC, EC2, EKS, Route53, IAM, Security Groups

Kubernetes → Deployments, Services, Ingress

Ingress Controller → NGINX or AWS ALB