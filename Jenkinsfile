pipeline {
    agent any

    environment {
        APP_NAME = "logo-server"
        REGISTRY = "prasadyadav99"
        IMAGE_TAG = readJSON(file: 'package.json').version
        IMAGE_NAME = "${REGISTRY}/${APP_NAME}:${IMAGE_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev',
                    url: 'https://github.com/prasadbeedam/devops-task.git'
            }
        }

        stage('Read Version') {
            steps {
                script {
                    def pkg = readJSON file: 'package.json'
                    env.IMAGE_TAG = pkg.version
                    env.IMAGE_NAME = "${env.REGISTRY}/${env.APP_NAME}:${env.IMAGE_TAG}"
                    echo "📦 Application version: ${env.IMAGE_TAG}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🐳 Building Docker image: ${env.IMAGE_NAME}"
                    sh "docker build -t ${env.IMAGE_NAME} ."
                }
            }
        }

        stage('Test') {
            steps {
                echo "✅ Running tests for version ${env.IMAGE_TAG}..."
                // Insert your test command if you have one
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh """
                          echo $PASSWORD | docker login -u $USERNAME --password-stdin
                          docker push ${env.IMAGE_NAME}
                          docker logout
                        """
                    }
                    echo "✅ Docker image pushed: ${env.IMAGE_NAME}"
                }
            }
        }

        stage('Update manifest.yaml') {
            steps {
                script {
                    sh """
                      sed -i 's|image: .*|image: ${env.IMAGE_NAME}|g' manifest.yaml
                      cat manifest.yaml
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                        sh """
                          aws eks update-kubeconfig --name logo-server-dev --region us-east-1
                          kubectl apply -f manifest.yaml
                        """
                    }
                }
            }
        }
    }
}
