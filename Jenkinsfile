    pipeline {
    agent any

    environment {
        APP_DIR = "examples/hello-world"
        IMAGE_NAME = "hello-world-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/prasadbeedam/devops-task.git'
                sh "git checkout dev"
            }
        }

        stage('Read Version') {
            steps {
                dir("${APP_DIR}") {
                    script {
                        def packageJson = readJSON file: 'package.json'
                        def appVersion = packageJson.version
                        echo "📦 Application version: ${appVersion}"

                        currentBuild.displayName = "v${appVersion}"
                        env.APP_VERSION = appVersion
                        env.FULL_IMAGE_NAME = "${IMAGE_NAME}:${appVersion}"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir("${APP_DIR}") {
                    echo "🐳 Building image: ${env.FULL_IMAGE_NAME}"
                    sh "docker build -t ${env.FULL_IMAGE_NAME} ."
                }
            }
        }

        stage('Run Container for Testing') {
            steps {
                echo "🚀 Running container from image: ${env.FULL_IMAGE_NAME}"
                sh "docker run -d --name test_container -p 3000:3000 ${env.FULL_IMAGE_NAME}"
            }
        }

        stage('Health Check Test') {
            steps {
                echo "🔍 Performing health check..."
                sh '''
                    sleep 5
                    curl -f http://localhost:3000 || exit 1
                '''
            }
        }

        stage('Run App Tests') {
            steps {
                echo "✅ Running tests..."
                dir("${APP_DIR}") {
                    sh "npm install"
                    sh "npm test || true"
                }
            }
        }
    }

    post {
        always {
            echo "🧹 Cleaning up test container..."
            sh '''
                docker stop test_c_
