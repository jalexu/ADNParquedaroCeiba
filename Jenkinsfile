pipeline {
  agent {
    label 'Slave_Mac'
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
 		disableConcurrentBuilds()
  }

  stages {
    stage('Compile') {
      steps {
        echo "------------>Compile<------------"
        sh 'pod install' // Esta instrucción puede variar dependiendo del gestor de paquetes.
        sh 'xcodebuild -scheme ADNParqueadero clean build CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED="NO"'
      }
    }
    stage('Unit Tests') {
      steps{
        echo "------------>Unit Tests<------------"
        sh 'xcodebuild test -scheme ADNParqueaderoTest -configuration "Debug"  -destination "platform=iOS Simulator,name=iPhone 14 Pro Max, OS=iOS 16.2"'
      }
    }
    stage('Static Code Analysis') {
      steps{
        echo '------------>Análisis estático<------------'
        withSonarQubeEnv('Sonar') {
          sh "${tool name: 'SonarScanner-Mac', type:'hudson.plugins.sonar.SonarRunnerInstallation'}/bin/sonar-scanner"
        }
      }
    }
    stage('Clean workspace') {
      steps {
        deleteDir()
      }
    }
  }
  post {
    failure {
      echo 'This will run only if failed'
      mail (to: 'jaime.uribe@ceiba.com.co',subject: "Failed Pipeline:${currentBuild.fullDisplayName}",body: "Something is wrong with ${env.BUILD_URL}")
    }
  }
}