pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub') // Jenkins credentials ID
        REMOTE_USER = 'ubuntu'
        REMOTE_HOST = '13.60.31.176'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/Setu3011/wanderlust-mini.git'
            }
        }

        stage('Skip NPM Install') {
            steps {
                dir('backend') {
                    sh '''
                        echo 📦 Skipping npm install...
                        if [ -d node_modules ]; then
                            echo ✅ node_modules already exists
                        else
                            echo ❌ node_modules missing. Exiting.
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
                        docker build -t setu3011/wanderlust-mini -f Dockerfile .
                    '''
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub', url: '']) {
                    sh 'docker push setu3011/wanderlust-mini'
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                sh '''
                echo 🚀 Deploying on EC2...
                ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST << EOF
                    docker rm -f wanderlust || true
                    docker pull setu3011/wanderlust-mini
                    docker run -d -p 3000:3000 --name wanderlust setu3011/wanderlust-mini
                EOF
                '''
            }
        }
    }

    post {
        failure {
            echo '❌ Deployment Failed. Please Check Logs.'
        }
        success {
            echo '✅ Deployment Successful! Visit http://13.60.31.176:3000'
        }
    }
}
