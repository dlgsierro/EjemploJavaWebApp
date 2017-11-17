pipeline {
	agent any
	stages {
		stage('Construcción') {
			steps {
				checkout scm
				sh 'mvn -DskipTests clean package'
				docker.build('tomcat-webapp')	
			}
		}
		stage('Pruebas') {
			steps {
				sh 'mvn test findbugs:findbugs'
			}
			post {
				success {
					junit 'target/surefire-reports/*.xml'
					jacoco()
					findbugs canComputeNew: false, defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', pattern: '**/findbugsXml.xml', unHealthy: ''
				}
			}
		}
		stage('Integrar') {
			agent {
				docker {
					image 'tomcat-webapp'
				}
			}
			steps {
				sh 'ls -lsa'
			}
		}
	}
	post {
		failure {
			emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.\nThanks,\nJenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'
		}
	}
}
