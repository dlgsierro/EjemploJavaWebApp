node {
	try {
		stage('Build') {
			checkout scm
			sh 'mvn -DskipTests clean install'
		}
		stage('Test') {
			sh 'mvn test findbugs:findbugs'
		}
		stage('Deploy') {
			docker.build('tomcat-maven').inside {
				sh 'mvn tomcat7:deploy'
			}
		}
	}
	catch(any) {
		throw any
		emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.

Thanks,
Jenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'
	}
	finally {
		junit 'target/surefire-reports/*.xml'
		jacoco()
		findbugs canComputeNew: false, defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', pattern: '**/findbugsXml.xml', unHealthy: ''
	}
}
