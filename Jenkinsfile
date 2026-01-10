pipeline{
    agent any

    environment
    {
        GIT_REPO ="https://github.com/vivekvennam/magicapp.git"
        APP_NAME = "Magicapp"
        IMAGE_NAME = "Magicapp-Image"
        CONTAINER_NAME ="Magic-conatainer"
        APP_PORT = "3000"

    }

    stages
    {
        stage('checkout Code')
        {
            steps
            {
               git branch : 'main', url:"${GIT_REPO}"
            }
        }

        stage('Build Docker Image')
        {
            steps
            {
                script
                {
                    env.VERSION = "v1.0.${BUILD_NUMBER}"
                    sh """
                        docker build -t ${IMAGE_NAME}:${VERSION} .
                        docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
                    """

                }
            }
        }

        stage('stop old container ')
        {
            steps
            {
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                """

            }
        }
        stage('run new conatainer')
        {
            steps
            {
                sh"""
                   docker run -d \
                   --name ${CONATINER_NAME}\
                   -e APP_VERSION =${VERSION}\
                   -p ${APP_PORT}:${APP_PORT}\
                   ${IMAGE_NAME}:latest
                """

            }
        }

       
    }
     post 
        {
            success

            {
                echo"DEPLOYMENT SUCCESS | Version: ${VERSION}"
            }
            failure 
            {
                echo " DEPLOYMENT FAILED !!!"
            }
        }
}