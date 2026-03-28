pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'http://host.docker.internal:9000'
        DOCKER_IMAGE = 'ivanskool/java-app:latest'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    docker.image('maven:3.9.9-eclipse-temurin-17').inside {
                        sh 'mvn clean package'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image('maven:3.9.9-eclipse-temurin-11').inside {
                        sh 'mvn test'
                    }
                }
            }
        }
        stage('Static Code Analysis') {
            steps {
                script {
                    docker.image('maven:3.9.9-eclipse-temurin-11').inside {
                        sh 'mvn sonar:sonar -Dsonar.host.url=${SONARQUBE_SERVER} -Dsonar.login=YOUR_TOKEN'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh 'docker push ${DOCKER_IMAGE}'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
