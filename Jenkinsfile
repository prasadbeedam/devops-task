pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                git branch: 'dev', url: 'https://github.com/prasadbeedam/devops-task.git'
            }
        }
        stage('Test') {
            steps {
                echo '✅ Running tests...'
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying...'
            }
        }
    }
}