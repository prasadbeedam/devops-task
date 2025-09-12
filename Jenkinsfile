pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/prasadbeedam/devops-task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t log-server-app:latest ."
            }
        }
    }
}
