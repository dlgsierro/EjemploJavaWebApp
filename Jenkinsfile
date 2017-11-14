pipeline {
    stages {
    	agent any
	    stage('Prepare') {
	    	checkout scm
	    	def env = docker.build 'tomcat-maven'
	    }
	    env.inside {
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