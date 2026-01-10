pipeline {
  agent any

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/YOUR_USERNAME/magicapp.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t magicapp:latest .'
      }
    }

    stage('Stop Old Container') {
      steps {
        sh 'docker rm -f magic-container || true'
      }
    }

    stage('Run New Container') {
      steps {
        sh 'docker run -d -p 3000:3000 --name magic-container magicapp:latest'
      }
    }
  }
}
