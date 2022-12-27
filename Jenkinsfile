pipeline {
  agent any
  environment {
        VERSION = "build-${BUILD_ID}"
        APP_REPO_NAME="mern-repo"
        AWS_ACCOUNT_ID=sh(script:'export PATH="$PATH:/usr/local/bin" && aws sts get-caller-identity --query Account --output text', returnStdout:true).trim()
        AWS_REGION="us-east-1"
        ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        USERNAME=sh(script: "aws secretsmanager get-secret-value --secret-id mongodb-secret |jq --raw-output '.SecretString' | jq -r .USERNAME", returnStdout:true).trim()
        PASSWORD=sh(script: "aws secretsmanager get-secret-value --secret-id mongodb-secret |jq --raw-output '.SecretString' | jq -r .PASSWORD", returnStdout:true).trim()
  }
  stages{
    stage('AWS token') {
      steps {
         sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY} "
          }
            }
        stage('Backend Image Build & Push') {
          steps {
              sh "echo Building Backend app..."
              git branch: 'main', url: 'https://github.com/ycetin94/task.git'
              sh "sed -i 's/USERNAME/${env.USERNAME}/g' mern-files/.env"
              sh "sed -i 's/PASSWORD/${env.PASSWORD}/g' mern-files/.env"
              sh "docker build -f mern-files/Dockerfile -t ${env.ECR_REGISTRY}/${env.APP_REPO_NAME}:backend-${env.VERSION} mern-files/"
              sh "docker push ${env.ECR_REGISTRY}/${env.APP_REPO_NAME}:backend-${env.VERSION}"
            }
          }
        stage('Frontend Image Build & Push') {
          steps {
              sh "echo Building Fronetend app..."
              git branch: 'main', url: 'https://github.com/ycetin94/task.git'
              sh "docker build -f mern-files/frontend/Dockerfile -t ${env.ECR_REGISTRY}/${env.APP_REPO_NAME}:frontend-${env.VERSION} mern-files/frontend/"
              sh "docker push ${env.ECR_REGISTRY}/${env.APP_REPO_NAME}:frontend-${env.VERSION}"
            }
          }
        }
    }
