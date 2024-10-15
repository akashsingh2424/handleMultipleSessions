pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockercred') // Assuming you have stored Docker Hub credentials in Jenkins
        DOCKER_HUB_REPO = 'awsakash/nodebakcend' // Replace with your Docker Hub repo
    }
    stages {
        stage('Checkout') {
            steps {
                // Clone the repository from Git
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    def appImage = docker.build("handlemultiplesessions:${env.BUILD_ID}")
                }
            }
        }
    }
     stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'DOCKER_HUB_CREDENTIALS') {
                        // Push the image to Docker Hub
                        def appImage = docker.image("${DOCKER_HUB_REPO}:${env.BUILD_ID}")
                        appImage.push() // Push the built image
                        appImage.push('latest') // Optionally tag and push as latest
                    }
                }
            }
     }

    post {
        always {
            // Clean up workspace after the build
            cleanWs()
        }
    }
}
