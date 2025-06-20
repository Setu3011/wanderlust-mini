pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        SSH_PRIVATE_KEY = credentials('shell-scripting-key')
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Setu3011/wanderlust-mini.git'
            }
        }

        stage('Install Backend Dependencies') {
            steps {
                dir('backend') {
                    sh '''
                        echo 📦 Installing backend dependencies...
                        sudo rm -rf node_modules package-lock.json || true
                        sudo npm cache clean --force
                        sudo npm install --legacy-peer-deps --no-audit --no-fund --unsafe-perm
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t setu3011/wanderlust-mini:latest .'
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub', url: '']) {
                    sh 'docker push setu3011/wanderlust-mini:latest'
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                writeFile file: 'ec2-key.pem', text: SSH_PRIVATE_KEY
                sh '''
                    chmod 400 ec2-key.pem
                    ssh -o StrictHostKeyChecking=no -i ec2-key.pem ubuntu@13.60.31.176 '
                        docker rm -f wanderlust-mini || true
                        docker pull setu3011/wanderlust-mini:latest
                        docker run -d -p 80:3000 --name wanderlust-mini setu3011/wanderlust-mini:latest
                    '
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Successfully Deployed Wanderlust Mini!'
        }
        failure {
            echo '❌ Deployment failed. Please check logs.'
        }
    }
}
