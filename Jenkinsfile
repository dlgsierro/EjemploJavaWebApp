pipeline {
	agent none
	stages {
		stage('Preparación') {
			agent { dockerfile true }
			steps {
				checkout scm
				docker.image('tomcat-webapp')
			}
		}
		stage('Construcción') {
			steps {
				sh 'mvn -DskipTests clean package'
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
			    input message: 'Approve deployment?'
			}
		}
	}
	post {
		failure {
			emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.\nThanks,\nJenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'
		}
	}
}
