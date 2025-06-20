pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "setu3011/wanderlust-mini"
        EC2_IP = "13.60.31.176"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git url: 'https://github.com/Setu3011/wanderlust-mini.git', branch: 'master'
            }
        }

        stage('Use Existing node_modules') {
            steps {
                dir('backend') {
                    sh '''
                        echo 📦 Skipping npm install. Using existing node_modules...
                        if [ -d "node_modules" ]; then
                            echo ✅ node_modules exists.
                        else
                            echo ❌ node_modules not found. Please install manually on EC2 or before running.
                            exit 1
                        fi
                    '''
                }
            }
        }

       stage('Build Docker Image') {
    steps {
        sh '''
            echo 🐳 Building Docker image...
            docker build -t $DOCKER_IMAGE -f Dockerfile .
        '''
    }
}


        stage('Push Docker Image to DockerHub') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub', url: '') {
                    sh '''
                        echo 📤 Pushing image to DockerHub...
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                sshagent (credentials: ['shell-scripting-key']) {
                    sh '''
                        echo 🚀 Deploying on EC2...
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP '
                            docker pull $DOCKER_IMAGE &&
                            docker stop wanderlust || true &&
                            docker rm wanderlust || true &&
                            docker run -d -p 8000:8000 --name wanderlust $DOCKER_IMAGE
                        '
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed. Please Check Logs.'
        }
    }
}
