pipeline {
    agent any

    environment {
        GIT_REPO        = "https://github.com/vivekvennam/magicapp.git"
        APP_NAME        = "Magicapp"
        IMAGE_NAME      = "magicapp-image"
        CONTAINER_NAME  = "magicapp-container"
        APP_PORT        = "3000"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    env.VERSION = "v1.0.${BUILD_NUMBER}"
                    sh """
                        docker build -t ${IMAGE_NAME}:${VERSION} .
                        docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                """
            }
        }

        stage('Run New Container') {
            steps {
                sh """
                    docker run -d \
                    --name ${CONTAINER_NAME} \
                    -e APP_VERSION=${VERSION} \
                    -p ${APP_PORT}:${APP_PORT} \
                    ${IMAGE_NAME}:latest
                """
            }
        }
    }

    post {
        success {
            echo "DEPLOYMENT SUCCESS 🚀 | Version: ${VERSION}"
        }
        failure {
            echo "DEPLOYMENT FAILED ❌"
        }
        always {
            sh "docker ps"
        }
    }
}
