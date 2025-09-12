pipeline {
    agent any

    environment {
        APP_DIR = "examples/hello-world"
        IMAGE_NAME = "hello-world-app"
        DOCKERHUB_USER = "prasadyadav99"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/prasadbeedam/devops-task.git'
                sh "git checkout dev"
            }
        }

    //     stage('List Files in hello-world') {
    //         steps {
    //             dir("${APP_DIR}") {
    //                 sh "ls -ltr"
    //             }
    //         }
    //     }

    //     stage('Read the Version') {
    //         steps {
    //             dir("${APP_DIR}") {
    //                 script {
    //                     def packageJson = readJSON file: 'package.json'
    //                     def appVersion = packageJson.version
    //                     echo "📦 Application version: ${appVersion}"

    //                     currentBuild.displayName = "v${appVersion}"
    //                     env.APP_VERSION = appVersion
    //                     env.IMAGE_TAG = "${IMAGE_NAME}:${appVersion}"
    //                     env.FULL_IMAGE_NAME = "${DOCKERHUB_USER}/${IMAGE_NAME}:${appVersion}"
    //                 }
    //             }
    //         }
    //     }

    //     stage('Build Docker Image') {
    //         steps {
    //             dir("${APP_DIR}") {
    //                 echo "🐳 Building image: ${env.FULL_IMAGE_NAME}"
    //                 sh "docker build -t ${env.FULL_IMAGE_NAME} ."
    //             }
    //         }
    //     }

    //     stage('Run Container for Testing') {
    //         steps {
    //             echo "🚀 Running container from image: ${env.FULL_IMAGE_NAME}"
    //             sh "docker run -d --name test_container -p 3000:3000 ${env.FULL_IMAGE_NAME}"
    //         }
    //     }

    //     stage('Health Check Test') {
    //         steps {
    //             echo '🔍 Running health check...'
    //             sh '''
    //                 sleep 5
    //                 curl -f http://localhost:3000 || exit 1
    //             '''
    //         }
    //     }

    //     stage('Test') {
    //         steps {
    //             echo '✅ Running application tests...'
    //             dir("${APP_DIR}") {
    //                 sh 'npm install'
    //                 sh 'npm test || true'
    //             }
    //         }
    //     }

    //     stage('Push to Docker Hub') {
    //         steps {
    //             script {
    //                 echo "📤 Pushing image: ${env.FULL_IMAGE_NAME}"
    //                 withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
    //                     sh """
    //                         echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
    //                         docker push ${env.FULL_IMAGE_NAME}
    //                         docker logout
    //                     """
    //                 }
    //                 echo "✅ Image successfully pushed: ${env.FULL_IMAGE_NAME}"
    //             }
    //         }
    //     }
    // }

    // post {
    //     always {
    //         echo "🧹 Cleaning up temporary containers..."
    //         sh '''
    //             docker stop test_container || true
    //             docker rm test_container || true
    //         '''
    //     }

    //     success {
    //         echo "🧼 Cleaning up workspace..."
    //         deleteDir()

    //         echo "🚀 Triggering CD pipeline with version ${env.APP_VERSION}"
    //         build job: 'hello-world-CD', parameters: [
    //             string(name: 'APP_VERSION', value: env.APP_VERSION)
    //         ]
    //     }

        failure {
            echo "❌ Build failed. Please check the logs."
        }
    }
}