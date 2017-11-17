node {
	try {
		stage('Preparación') {
			cleanWs()
			checkout csm
			docker.build 'tomcat-webapp'
		}
		stage('Construcción') {
			sh 'mvn -DskipTests clean package'
		}
		stage('Pruebas') {
			sh 'mvn test findbugs:findbugs'
			junit 'target/surefire-reports/*.xml'
			jacoco()
			findbugs canComputeNew: false, defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', pattern: '**/findbugsXml.xml', unHealthy: ''
		}
		stage('Integración') {
			docker.image('tomcat-webapp').inside() {
				sh 'ls -ls /usr/local/tomcat/webapps/'
				script {
					input message: 'Approve deployment?'
				}
			}
		}
	}
	catch (any) {
		emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.\nThanks,\nJenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'
		throw any
	}
}
