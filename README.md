# EksDemo
Project: Deploying a Static Web Application on AWS EKS using Terraform and Helm

In this project, I provisioned a highly available Kubernetes cluster on AWS using Terraform and deployed a custom static web application via Helm. The infrastructure and deployment flow includes the following key components:

Amazon EKS Cluster Provisioning:
Using Terraform, I automated the creation of an EKS cluster along with the necessary VPC, subnets, IAM roles, and self-managed node groups to host containerized workloads.

Application Deployment via Helm:
I developed a custom Helm chart for a static web application and used it to package and deploy the application onto the EKS cluster. This approach enabled reusability, version control, and simplified updates.

NGINX Ingress with AWS Network Load Balancer:
To expose the application externally, I deployed the NGINX Ingress Controller and integrated it with an AWS Network Load Balancer (NLB) using Terraform and Helm annotations. This provided scalable, secure, and reliable access to the application over the internet.

Infrastructure as Code:
The entire infrastructure, including the EKS cluster, Helm releases, Ingress, and load balancer setup, was fully codified using Terraform, enabling consistent, repeatable deployments.


web-app/
├── helm-main.tf
└── my-webapp/
    ├── Chart.yaml
    ├── values.yaml
    ├── templates/
    │   └── deployment.yaml, service.yaml, ingress.yaml, etc.