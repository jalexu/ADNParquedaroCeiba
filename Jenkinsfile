pipeline {
  agent {
    label 'Slave_Mac'
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
 		disableConcurrentBuilds()
  }

  stages {
    stage('Build') {
      steps {
        echo "------------>Compile<------------"
        sh 'pod install' // Esta instrucción puede variar dependiendo del gestor de paquetes.
        sh 'xcodebuild -workspace ADNParqueadero.xcworkspace -scheme ADNParqueadero -destination "platform=iOS Simulator,name=iPhone 14 Pro Max" build'
      }
    }
    stage('Unit Tests') {
      steps{
        echo "------------>Unit Tests<------------"
        sh 'xcodebuild -workspace ADNParqueadero.xcworkspace -scheme ADNParqueadero -configuration "Debug" -destination "platform=iOS Simulator,name=iPhone 14 Pro Max" test'
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
  }
  post {
    failure {
      echo 'This will run only if failed'
      mail (to: 'jaime.uribe@ceiba.com.co',subject: "Failed Pipeline:${currentBuild.fullDisplayName}",body: "Something is wrong with ${env.BUILD_URL}")
    }
  }
}