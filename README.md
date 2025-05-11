🚀 Automated AWS EKS Deployment with Terraform, Helm, and Jenkins CI/CD
Your project is a highly automated, scalable, and secure AWS EKS deployment featuring:

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
Custom Helm Chart: To deploy the static web app on the EKS cluster.
Configurable values: Control replica count, resource limits, and ingress rules via Helm chart.
Code Source: Web app code pulled from GitHub.
CI/CD Pipeline (Jenkins + GitHub Webhooks)
Jenkinsfile: Defines build, test, and deploy stages.
GitHub Webhook: Automatically triggers the pipeline on code push.
Kubernetes Deployment: Using Helm to deploy the static web app onto EKS.

🧪 Testing & Quality Assurance
We’ve included the following tests to ensure the application and infrastructure are secure and functional:

Dockerfile Linting:
Test: Linting the Dockerfile using hadolint to ensure it adheres to best practices and avoids common issues.
Stage: Dockerfile Lint
Security Scanning:
Test: Scans the Docker image using Trivy for high and critical security vulnerabilities.
Stage: Security Scan (Trivy)
Terraform Validation:
Tests:
Formatting: Ensures the Terraform code is properly formatted using terraform fmt -check.
Syntax Validation: Validates the Terraform configuration with terraform validate.
Execution Plan: Runs terraform plan to ensure the changes are correct and to detect potential issues.
Stage: Terraform Validate


🚀 Key Benefits
Automation: Infrastructure provisioning, application deployment, and testing are fully automated.
Security: Code scanning and security testing ensure vulnerabilities are caught early.
Scalability: EKS and NGINX Ingress + AWS NLB make the app ready for scaling with minimal intervention.
CI/CD Efficiency: Jenkins triggers an automatic pipeline on code pushes to GitHub, ensuring fast and reliable deployments.


To trigger your Jenkins pipeline automatically on GitHub changes, follow these steps:

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
✅ 4. Make Sure Jenkinsfile Is in the Repo
Your Jenkinsfile should be in the root of the GitHub repository.


🚀 Goal: Trigger Jenkins Pipeline Automatically When Code Is Pushed to GitHub

✅ You Need:
A GitHub repository
A Jenkins server with a working pipeline job
Jenkins GitHub plugin installed
A Webhook in GitHub pointing to Jenkins
🛠️ Step-by-Step Setup

🔹 Step 1: Configure Jenkins Job
Open your Jenkins pipeline job.
Click Configure.
Scroll to Build Triggers.
Check ✅ GitHub hook trigger for GITScm polling.
Save.
🔹 Step 2: Get Your Jenkins Webhook URL
Use this format:

http://<your-jenkins-domain>/github-webhook/
If running Jenkins locally: http://<your-public-IP>:8080/github-webhook/
You need Jenkins to be accessible from GitHub (use ngrok if it's not public).
Example:

http://3.88.45.12:8080/github-webhook/
🔹 Step 3: Add Webhook in GitHub
Go to your GitHub repo.
Click Settings > Webhooks > Add Webhook.
In Payload URL, paste your Jenkins webhook URL (from Step 2).
Set Content type to application/json.
Choose Just the push event.
Click Add Webhook.
🔹 Step 4: Make Sure Jenkins Can Access GitHub Repo
In your pipeline:

git branch: 'main', url: 'https://github.com/ChanukyaPathipati/EksDemo'
This works if your repo is public.
If private, add GitHub credentials in Jenkins and use HTTPS with credentials or SSH.
✅ Done! Test it
Push a change to your GitHub repo.
Go to GitHub > Repo > Settings > Webhooks > Recent Deliveries to see if it fired.
Your Jenkins job should run automatically.



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

