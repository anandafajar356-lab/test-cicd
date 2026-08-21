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
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    # 1. Login menggunakan binary docker di jenkins_home
                    echo "\$DOCKER_PASS" | /var/jenkins_home/docker login -u "\$DOCKER_USER" --password-stdin

                    # 2. Build Image
                    /var/jenkins_home/docker build -t ${env.DOCKER_USERNAME}/${env.DOCKER_HUB_REPO}:${env.BUILD_NUMBER} -t ${env.DOCKER_USERNAME}/${env.DOCKER_HUB_REPO}:latest .

                    # 3. Push Image ke Docker Hub
                    /var/jenkins_home/docker push ${env.DOCKER_USERNAME}/${env.DOCKER_HUB_REPO}:${env.BUILD_NUMBER}
                    /var/jenkins_home/docker push ${env.DOCKER_USERNAME}/${env.DOCKER_HUB_REPO}:latest
                    """
                }
            }
        }

        stage('Deploy to K8s') {
            steps {
                withKubeConfig([credentialsId: 'kubeconfig-k8s']) {
                    sh "kubectl apply -f nginx-withrc.yaml --namespace it"
                    sh "kubectl rollout restart deployment nginx-rs --namespace it"
                }
            }
        }
    }
}
