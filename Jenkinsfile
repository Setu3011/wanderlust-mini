pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    IMAGE_NAME = 'setu3011/wanderlust-backend'
    CONTAINER_NAME = 'wanderlust-backend'
    SSH_KEY = credentials('shell-scripting-key')
    HOST = 'ubuntu@13.60.31.176'
  }

  stages {

    stage('Clone Repo') {
      steps {
        git url: 'https://github.com/Setu3011/wanderlust-mini.git', branch: 'master'
      }
    }

    stage('Install Backend Dependencies') {
      steps {
        dir('backend') {
          sh '''
            echo 📦 Installing backend dependencies...
            rm -rf node_modules package-lock.json || true
            npm cache clean --force
            npm install --legacy-peer-deps --no-audit --no-fund --unsafe-perm
          '''
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        dir('backend') {
          sh '''
            echo 🐳 Building Docker image...
            docker build -t $IMAGE_NAME .
          '''
        }
      }
    }

    stage('Push Docker Image to DockerHub') {
      steps {
        withDockerRegistry([credentialsId: 'dockerhub', url: '']) {
          sh 'docker push $IMAGE_NAME'
        }
      }
    }

    stage('Deploy on EC2') {
      steps {
        sh '''
          echo 🚀 Deploying to EC2...
          ssh -i $SSH_KEY -o StrictHostKeyChecking=no $HOST '
            docker stop $CONTAINER_NAME || true
            docker rm $CONTAINER_NAME || true
            docker pull $IMAGE_NAME
            docker run -d --name $CONTAINER_NAME -p 8000:8000 $IMAGE_NAME
          '
        '''
      }
    }
  }

  post {
    failure {
      echo '❌ Deployment failed. Please check logs.'
    }
    success {
      echo '✅ Successfully deployed backend!'
    }
  }
}
