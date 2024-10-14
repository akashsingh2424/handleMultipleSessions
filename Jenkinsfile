pipeline {
    agent any

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
                    def appImage = docker.build("handleMultipleSessions:${env.BUILD_ID}")
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
