pipeline {
    agent {
    	docker{
    	    image: 'tomcat:8.0-jre8-alpine'
    	}
	}
	tools {
        maven 'apache-maven-3.5.2' 
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
    	    emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.

Thanks,
Jenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'

	    }
    }
}