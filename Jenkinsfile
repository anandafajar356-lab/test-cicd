pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build & Push Image') {
            steps {
                script {
                    // This uses Jenkins Docker Pipeline plugin
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        def myImage = docker.build("${DOCKER_USERNAME}/${DOCKER_HUB_REPO}:${env.BUILD_NUMBER}")
                        myImage.push()
                        myImage.push("latest")
                    }
                }
            }
        }
        stage('Deploy to MicroK8s') {
            steps {
                // This is the standard way with the Kubernetes CLI plugin
                withKubeConfig([credentialsId: "${KUBECONFIG_CRED_ID}"]) {
                    sh "kubectl apply -f nginx-withrc.yaml --namespace it"
                }
            }
        }
    }
}