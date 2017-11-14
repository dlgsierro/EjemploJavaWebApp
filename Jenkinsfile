node {
	try {
	    stage('Prepare') {
	    	def app = docker.build('tomcat-maven')
	    }
	    stage('Build') {
	        steps {
	        	app.inside {
	    			checkout scm
		            sh 'mvn -DskipTests clean install'
	        	}
	        }
	    }
	    stage('Test') {
	        steps {
	        	app.inside {
	            	sh 'mvn test findbugs:findbugs'
	            }
	        }
			post {
		        success {
		            junit 'target/surefire-reports/*.xml'
		            jacoco()
		            findbugs canComputeNew: false, defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', pattern: '**/findbugsXml.xml', unHealthy: ''
		        }
		    }
	    }
	    stage('Deploy') {
	        steps {
	        	app.inside {
	            	sh 'mvn tomcat7:deploy'
	            }
	        }
	    }
	}
	catch(any) {
		throw any
   	    emailext body: '''Your jenkins job \'webapp\' is failling, please review your submitted code and do the fixes.

Thanks,
Jenkins''', subject: 'Jenkins failure', to: 'gsierro@dl.cl'
	}
}