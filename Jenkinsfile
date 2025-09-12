pipeline {
    agent any

    environment{
        def appVersion = '' //variable declaration
    }

    stages {
        stage('Build') {
            steps {
                git branch: 'dev', url: 'https://github.com/prasadbeedam/devops-task.git'
            }
        }
        stages {
        stage('read the version'){
            steps{
                script{
                    def packageJson = readJSON file: 'package.json'
                    appVersion = packageJson.version
                    echo "application version: $appVersion"
                }
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
