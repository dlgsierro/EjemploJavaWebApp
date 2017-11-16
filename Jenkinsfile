pipeline {
	agent {
		docker {
			image: 'tomcat:8.0-jre8-alpine'
		}
	}
	stages {
		stage('Build') {
			steps {
				sh 'mvn -DskipTests clean install'
			}
		}
		stage('Test') {
			steps {
				sh 'mvn test findbugs:findbugs'
			}
		}
		stage('Deploy') {
			steps {
				sh 'mvn tomcat7:deploy'
			}
		}
	}
	post {
		always {
			junit 'target/surefire-reports/*.xml'
			jacoco()
			findbugs canComputeNew: false, defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', pattern: '**/findbugsXml.xml', unHealthy: ''
		}
		failure {
			emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.\nThanks,\nJenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'
		}
	}
}