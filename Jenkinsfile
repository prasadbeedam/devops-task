pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                git 'https://github.com/prasadbeedam/devops-task.git'
                sh "git checkout dev"
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
