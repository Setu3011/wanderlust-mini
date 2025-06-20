pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Setu3011/wanderlust-mini.git'
            }
        }

        stage('Build Image') {
            steps {
                script {
                    sh 'docker build -t wanderlust-backend .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh 'docker stop wanderlust || true'
                    sh 'docker rm wanderlust || true'
                    sh 'docker run -d -p 3000:3000 --name wanderlust wanderlust-backend'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Wanderlust backend deployed successfully!'
        }
        failure {
            echo '❌ Something went wrong!'
        }
    }
}

