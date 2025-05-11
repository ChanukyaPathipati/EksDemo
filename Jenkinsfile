pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '281695752858'
        ECR_REPO = 'jenkinstest'
        IMAGE_TAG = 'latest'
        DOCKER_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                echo "Checking AWS CLI..."
                if ! command -v aws &> /dev/null
                then
                    echo "Installing AWS CLI (ARM version)..."
                    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
                    unzip -o awscliv2.zip
                    ./aws/install
                else
                    echo "AWS CLI already installed."
                fi

                echo "Checking Docker..."
                if ! command -v docker &> /dev/null
                then
                    echo "Installing Docker..."
                    apt-get update
                    apt-get install -y docker.io
                else
                    echo "Docker already installed."
                fi

                echo "Checking Terraform..."
                if ! command -v terraform &> /dev/null
                then
                    echo "Installing Terraform..."
                    apt-get update && apt-get install -y gnupg software-properties-common curl
                    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
                    apt-get update && apt-get install terraform -y
                else
                    echo "Terraform already installed."
                fi
                '''
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ChanukyaPathipati/EksDemo'
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh '''
                        echo "Logging in to Amazon ECR..."
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to ECR') {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir('terraform') {
                        sh '''
                        echo "Initializing and applying Terraform..."
                        terraform init
                        terraform plan -out=tfplan
                        terraform apply -auto-approve tfplan
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
