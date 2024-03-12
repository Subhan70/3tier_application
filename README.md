# #TWSThreeTierAppChallenge

## Overview
The challenge involves deploying a Three-Tier Web Application using ReactJS, NodeJS, and MongoDB across Multi-Cloud Platforms. This repository contains Jenkins pipelines for deploying infrastructure using Terraform, installing ALB Ingress Controller, and building and deploying Docker images to Kubernetes. 

**Project Architecture**

![Project Architecture](https://github.com/rajatsardesai/Terraform-Multi-Cloud-Deployment/assets/29860438/27dd943d-9175-46a0-a2b7-f852351e5be0)

## Contribution Opportunity
Contribute by completing the Azure part of the project, including setting up Azure resources, configuring Azure pipelines, writing kubernetes menifests file for azure and addressing any Azure-specific troubleshooting steps. Your expertise can help enhance the project's multi-cloud capabilities and provide a comprehensive deployment solution.

## Challenge Steps
- [Application Code](#application-code)
- [Jenkins Pipeline Code](#jenkins-pipeline-code)
- [Jenkins Server Terraform](#jenkins-server-terraform)
- [Kubernetes Manifests Files](#kubernetes-manifests-files)
- [Project Details](#project-details)

## Application Code
The `Application-Code` directory contains the source code for the Three-Tier Web Application. Dive into this directory to explore the frontend and backend implementations.

## Jenkins Pipeline Code
In the `Jenkins-Pipeline-Code` directory, you'll find Jenkins pipeline scripts. These scripts automate the CI/CD process, ensuring smooth integration and deployment of your application.

## Jenkins Terraform
Explore the `terraform` directory to find Terraform scripts for setting up the Jenkins Server on AWS, Azure and GCP. These scripts simplify the infrastructure provisioning process.

## Kubernetes Manifests Files
The `Kubernetes-Manifests-Files` directory holds Kubernetes manifests for deploying your application on AWS EKS, Azure AKS and GCP GKE. Understand and customize these files to suit your project needs.

## Project Details
🛠️ **Tools Explored:**
- Terraform & AWS, Azure & GCP CLI for multicloud infrastructure
- Jenkins, Sonarqube, Terraform, Kops, Kubectl, and more for CI/CD setup

🚢 **High-Level Overview:**
- IAM User, Service account setup & Terraform Jenkins magic on AWS, Azure and GCP
- Kubernetes Jenkins deployment with AWS, Azure and GCP integration
- EKS, AKS and GKE Cluster creation & Load Balancer configuration
- Helm charts for efficient monitoring setup

📈 **The journey covered everything from setting up tools to deploying a Three-Tier app on multicloud, ensuring data persistence, and implementing CI/CD pipelines.**

## Prerequisites
### Terraform Pipeline (Jenkinsfile-Terraform)
- Storage Buckets: Create storage buckets in all cloud services.
- IAM Setup: Create IAM user, Entra ID, and GCP service account.
- Jenkins Setup: Setup Jenkins instance on any one of the cloud provider and add GCP, AWS, and bucket credentials.
- Azure Setup: Add Azure security realm and authorization Azure credentials. Assign Contributor role to the service principal.
- GCP Setup: Add the secret-key file to the credentials without any plugin.
- Jenkins Plugins: Install necessary Jenkins plugins including AWS Pipeline Steps, Google Cloud SDK, Azure Credentials, Azure CLI, Microsoft Entra ID, Google Kubernetes Engine, CloudBees Docker Build and Publish, and OWASP Dependency-CheckVersion.
- Verify Azure Subscription ID: Assign Azure roles using by running following command using Azure CLI.
``` shell
az ad sp list --display-name three-tier-multistage
az role assignment create --assignee "{appId}" \
--role "{roleNameOrId}" \
--scope "/subscriptions/{subscriptionId}"
```
- Google Cloud SDK: Install Google Cloud SDK on the Jenkins server and configure its path in the global settings of Jenkins. Also, configure the plugin in tools and add GCP credentials.
- Environment Variables: Add export GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/gcp_service-account-key.json in ~/.bashrc file of the Jenkins server and set GOOGLE_APPLICATION_CREDENTIALS as an environmental variable in Jenkins.
- JDK Installation: Install the latest version of JDK and set JAVA_HOME.
- Kubernetes Installation: Install kubernetes cli version v1.23.6.

### ALB Ingress Controller Installation Pipeline (Jenkinsfile-ALB)
- Ensure Kubernetes cluster is up and running.
- Helm is installed on the Kubernetes cluster.

### Docker Image Build and Deployment Pipeline (Jenkinsfile-Kubernetes)
- Kops Instance: Create Kops instance and bucket on each cloud provider and Create folder /opt/jenkins-slave.
- Sonar Server: Install Sonar server on any one of the cloud provider.
- Sonar Setup: Create a token from Sonar server, install Sonar plugin in Jenkins, and add the token to it.
- Docker Credentials: Add Docker credentials to Jenkins and install Docker on the Jenkins server to build images. Add Jenkins to the Docker group.
- Helm Installation: Install Helm in AWS, GCP, and Azure kops VMs.
- Jenkins Slaves: Add all Kops instances as a slave in Jenkins. Install JDK-17 or latest JDK on Kops server and make Ubuntu the owner of the directory jenkins-slave. Allow Kops security group to SSH from Jenkins security group by adding port 22 to Jenkins security group.
- Amazon EBS CSI Driver Add-on: Enable Amazon EBS CSI Driver manually in addons section of cluster in aws console and create IAM policy for the same referring to following link: https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
- Upload kubectl file: Upload kubectl file of aws, azure and gcp as a secret file credential in Jenkins.

### Important Notes
- Please use the credential ID name mentioned in Jenkins code or rename it as per your needs.
- Change the serverUrl of Create namespace stage in Jenkins-Kubernetes file.

## Contribution Guidelines
- Fork the repository and create your feature branch.
- Deploy the application, adding your creative enhancements.
- Ensure your code adheres to the project's style and contribution guidelines.
- Submit a Pull Request with a detailed description of your changes.

## Support
For any queries or issues, please open an issue in the repository.

---
Happy Learning! 🚀👨‍💻👩‍💻
