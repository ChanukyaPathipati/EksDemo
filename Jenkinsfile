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

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ChanukyaPathipati/EksDemo'
            }
        }

        stage('Dockerfile Lint') {
            steps {
                sh 'hadolint Dockerfile'
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

        stage('Security Scan (Trivy)') {
            steps {
                sh 'trivy image --exit-code 0 --severity HIGH,CRITICAL $DOCKER_IMAGE'
            }
        }

        stage('Push to ECR') {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform fmt
                        terraform init
                        terraform validate
                        terraform plan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir('terraform') {
                        sh '''
                            echo "Applying Terraform changes..."
                            terraform apply -auto-approve
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
