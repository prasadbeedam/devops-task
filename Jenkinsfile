pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/prasadbeedam/devops-task.git'
            }
        }

        stage('Read Version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    def appVersion = packageJson.version
                    echo "📦 Application version: ${appVersion}"

                    // store version for later stages
                    env.APP_VERSION = appVersion
                }
            }
        }

        stage('Test') {
            steps {
                echo "✅ Running tests for version ${env.APP_VERSION}..."
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Deploying version ${env.APP_VERSION}..."
            }
        }
    }
}
