pipeline {
    agent any
    
    tools {
        maven 'Maven'
        jdk 'JDK17'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Obteniendo código desde Git...'
                checkout scm
            }
        }
        
        stage('Compile') {
            steps {
                echo 'Compilando el proyecto...'
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Ejecutando pruebas...'
                sh 'mvn test'
            }
            post {
                always {
                    publishTestResults testResultsPattern: 'target/surefire-reports/*.xml'
                    archiveArtifacts artifacts: 'target/surefire-reports/*', fingerprint: true
                }
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
