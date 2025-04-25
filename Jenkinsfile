pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'anon-ecommerce-website'
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                    } catch (Exception e) {
                        echo "Error building Docker image: ${e.message}"
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    echo 'Running tests...'
                    // Add any tests here if needed
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    try {
                        // Stop and remove any existing container
                        bat "docker stop ${DOCKER_IMAGE} || exit 0"
                        bat "docker rm ${DOCKER_IMAGE} || exit 0"
                        
                        // Run the new container
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").run(
                            "--name ${DOCKER_IMAGE} -p 80:80"
                        )
                    } catch (Exception e) {
                        echo "Error deploying container: ${e.message}"
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Clean up workspace
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
} 