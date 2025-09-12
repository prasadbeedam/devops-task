pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'prasadyadav99'
        IMAGE_NAME = 'logo-server'
    }

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
                    env.APP_VERSION = packageJson.version
                    env.FULL_IMAGE_NAME = "${DOCKERHUB_USER}/${IMAGE_NAME}:${APP_VERSION}"
                    echo "📦 Application version: ${env.APP_VERSION}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image: ${env.FULL_IMAGE_NAME}"
                sh "docker build -t ${env.FULL_IMAGE_NAME} ."
            }
        }

        stage('Test') {
            steps {
                echo "✅ Running tests for version ${env.APP_VERSION}..."
                // Optional: run tests, e.g., sh "npm test"
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh """
                        echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
                        docker push ${env.FULL_IMAGE_NAME}
                        docker logout
                        """
                    }
                    echo "✅ Docker image pushed: ${env.FULL_IMAGE_NAME}"
                }
            }
        }

        stage('Update manifest.yaml') {
            steps {
                echo "📝 Updating manifest.yaml with new image: ${env.FULL_IMAGE_NAME}"
                sh """
                sed -i 's|image: .*|image: ${FULL_IMAGE_NAME}|g' manifest.yaml
                cat manifest.yaml
                """
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "🚀 Deploying version ${env.APP_VERSION} to cluster"
                sh "kubectl apply -f manifest.yaml"
            }
        }
    }
}
