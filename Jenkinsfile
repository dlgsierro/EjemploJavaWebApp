node {
	try {
		stage('Prepare') {
			docker.build('tomcat-maven')
			def app = docker.image('tomcat-maven')
		}
		stage('Build') {
			app.inside {
				checkout scm
				sh 'mvn -DskipTests clean install'
			}
		}
		stage('Test') {
			app.inside {
				sh 'mvn test findbugs:findbugs'
			}
		}
		stage('Deploy') {
			app.inside {
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
