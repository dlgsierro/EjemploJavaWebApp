pipeline {
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
    stages {
		stage('Build') {
	        steps {
	            sh 'mvn -B -DskipTests clean package'
	        }
	    }
	    stage('Test') {
	        steps {
	            sh 'mvn test'
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
    	    emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.

Thanks,
Jenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'

	    }
    }
}