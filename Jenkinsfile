node {
	try {
		stage('Preparación') {
			cleanWs()
			checkout scm
		}
		stage('Construcción') {
			sh 'mvn -DskipTests clean package'
			docker.build 'tomcat-webapp'
		}
		stage('Pruebas') {
			sh 'mvn test findbugs:findbugs'
			junit 'target/surefire-reports/*.xml'
			jacoco()
			findbugs canComputeNew: false, defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', pattern: '**/findbugsXml.xml', unHealthy: ''
		}
		stage('Integración') {
			sh 'docker run -it -p 80:8080 tomcat-webapp'
			script {
				input message: 'Approve deployment?'
			}
		}
	}
	catch (any) {
		emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.\nThanks,\nJenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'
		throw any
	}
}
