pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "setu3011/wanderlust-mini"
        EC2_IP = "56.228.28.15"
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
                        if [ -d node_modules ]; then
                          echo ✅ node_modules exists.
                        else
                          echo ❌ node_modules not found. Exiting.
                          exit 1
                        fi
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('backend') {
                    sh '''
                        echo 🐳 Building Docker image...
                        docker build -t $DOCKER_IMAGE .
                    '''
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo 🔐 Logging into DockerHub...
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $DOCKER_IMAGE
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                echo '🚀 Deploying on EC2 instance...'
                sshagent(['shell-scripting-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP << EOF
                      docker stop wanderlust || true
                      docker rm wanderlust || true
                      docker pull $DOCKER_IMAGE
                      docker run -d -p 3000:3000 --name wanderlust $DOCKER_IMAGE
                    EOF
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo '❌ Deployment Failed. Please check the logs.'
        }
        success {
            echo '✅ Deployment Successful! Visit: http://56.228.28.15:3000'
        }
    }
}
