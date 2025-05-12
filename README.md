🚀 Automated AWS EKS Deployment with Terraform, Helm, and Jenkins CI/CD
My project is a highly automated, scalable, and secure AWS EKS deployment featuring:
✅ Terraform for EKS cluster, VPC, IAM provisioning
✅ Custom Helm chart for flexible static web app deployment
✅ NGINX Ingress + AWS NLB for seamless app access
✅ Auto-generated SSH keypairs (stored securely in S3) for EKS node security
✅ Jenkins CI/CD pipeline triggered on GitHub code push

📐 Architecture Overview

Infrastructure as Code (Terraform)
EKS Cluster: Managed worker nodes, IAM roles, and security groups.
VPC Networking: Includes subnets, NAT Gateway, and Internet Gateway for proper networking.
S3 Bucket: Secure storage for SSH keypairs used by EKS worker nodes.
NGINX Ingress Controller: Exposed via AWS NLB to route traffic to your services.
Application Deployment (Helm)
Custom Helm Chart: Deploy the static web app on the EKS cluster.
Configurable Values: Control replica count, resource limits, and ingress rules via the Helm chart.
Code Source: Web app code pulled from GitHub.
CI/CD Pipeline (Jenkins + GitHub Webhooks)
Jenkinsfile: Defines build, test, and deploy stages.
GitHub Webhook: Automatically triggers the pipeline on code push.
Kubernetes Deployment: Use Helm to deploy the static web app onto EKS.

🧪 Testing & Quality Assurance
We’ve included the following tests to ensure the application and infrastructure are secure and functional:

Dockerfile Linting:
Test: Linting the Dockerfile using hadolint to ensure it adheres to best practices and avoids common issues.
Stage: Dockerfile Lint

Security Scanning:
Test: Scans the Docker image using Trivy for high and critical security vulnerabilities.
Stage: Security Scan (Trivy)

🚀 Key Benefits
Automation: Infrastructure provisioning, application deployment, and testing are fully automated.
Security: Code scanning and security testing ensure vulnerabilities are caught early.
Scalability: EKS and NGINX Ingress + AWS NLB make the app ready for scaling with minimal intervention.
CI/CD Efficiency: Jenkins triggers an automatic pipeline on code pushes to GitHub, ensuring fast and reliable deployments.


To trigger your Jenkins pipeline automatically on GitHub changes, follow these steps:

Prerequisites:
The following should be installed in the jenkins server to run the pipeline
1.)AWS CLI ,2)Terraform ,3)Docker ,4)Hadolit ,5)Trivy

hence I am using docker to run my jenkins server 
1) use below command to run the container name jenkins with the jenkins image with root permisions.
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -u root \
  jenkins/jenkins:lts

2) to login to the container

docker exec -it <your_container_name> /bin/bash

3) Install all Prerequisites according to your Image architecture


✅ You Need:
A GitHub repository
A Jenkins server with a working pipeline job
Jenkins GitHub plugin installed
A Webhook in GitHub pointing to Jenkins
🛠️ Step-by-Step Setup

✅ 1. Enable GitHub Webhook Support in Jenkins
In Jenkins:
Go to Manage Jenkins > Configure System.
Under GitHub, ensure GitHub plugin is installed and credentials are configured.
Under GitHub Web Hook, check "Let Jenkins auto-manage hook URLs".

✅ 2. Configure Your Jenkins Job for GitHub Trigger
In your Jenkins job (Pipeline or Multibranch Pipeline):
Go to Configure.
Scroll to Build Triggers.
Check: ✅ GitHub hook trigger for GITScm polling.
-> In pipeline definition select pipeline script from SCM
-> SCM->git
-> Repository -> past your repo url and provide credentials if it is private repo 
other wise no need.
-> branches to build -> select proper branch ex= */main if it is main branch
-> script file->Jenkinsfile

✅ 3. Set Up GitHub Webhook
On your GitHub repo:
Go to Settings > Webhooks > Add Webhook
Payload URL:
http://<YOUR_JENKINS_URL>/github-webhook/
Example:

http://your-jenkins-server.com/github-webhook/
Content type: application/json
Events: Just the Push events
Click Add webhook

For Webhook :

I am using ngrok for my github to access my jenkins 
because I am running Jenkins in my Docker conatiner which is in my local machine


❗ Local Development - Use ngrok for Public URL
If Jenkins is running on your local machine and you want GitHub to access it, you'll need a public URL for Jenkins.

You can use ngrok to expose your local Jenkins to the public internet.

Install ngrok:
brew install ngrok   # macOS
# or
sudo apt install ngrok  # Linux

Run ngrok:
ngrok http 8080
Copy the URL:
ngrok will give you a public URL (e.g., http://abcd1234.ngrok.io), which you can use for the webhook.
Example:

http://abcd1234.ngrok.io/github-webhook/



✅ 4. Make Sure Jenkinsfile Is in the Repo
Your Jenkinsfile should be in the root of the GitHub repository.


output:

![Alt text](<Screenshot 2025-05-12 at 1.03.14 AM.png>)