pipeline {
    agent any
    
    triggers {
        githubPush()  // Se ejecuta cuando GitHub envía webhook
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Obteniendo código desde GitHub  ...'
                git url: 'https://github.com/AlejandroCalzadilla/jenkins.git', branch: 'main'
            }
        }
        
        stage('Compile') {
            steps {
                echo 'Compilando el proyecto...'
                sh 'mvn clean compile'
            }
        }
        
      
        
        stage('Package') {
            steps {
                echo 'Empaquetando aplicación...'
                sh 'mvn package -DskipTests'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }
            }
        }
        
        stage('Deploy to Staging') {
            steps {
                echo 'Simulando despliegue a staging...'
                sh 'echo "Aplicación empaquetada correctamente"'
                sh 'ls -la target/*.jar'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completado'
            cleanWs()
        }
        success {
            echo 'Build exitoso!'
        }
        failure {
            echo 'Build falló!'
        }
    }
}
