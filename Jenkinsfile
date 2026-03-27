pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'http://sonar:9000'
        DOCKER_IMAGE = 'ivanskool/java-app:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/IvanMed1002/java-app', branch: 'main'
            }
        }

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
                    docker.image('maven:3.8.8-eclipse-temurin-8').inside {
                        sh 'mvn sonar:sonar -Dsonar.host.url=${SONARQUBE_SERVER}'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'docker login -u ivanskool -p iala_153523'
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
