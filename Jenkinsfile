pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="670166063118"
        AWS_DEFAULT_REGION="us-east-1" 
	CLUSTER_NAME="AngualAppCluster"
	SERVICE_NAME="AngualAppService"
	TASK_DEFINITION_NAME="AngualAppTask"
	DESIRED_COUNT="2"
        IMAGE_REPO_NAME="angulardemo"
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
	registryCredential = "ec2-user"
    }
   
    stages {

    // Tests
    //stage('Unit Tests') {
      //steps{
        //script {
          //sh 'npm install'
	  //sh 'npm test -- --watchAll=false'
        //}
      //}
    //}
        
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
			docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential) {
                    	dockerImage.push()
                	}
         }
        }
      }
      
	 stage('Deploy in ECS') {
  	steps {
     		sh "aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --force-new-deployment"
           
      		}
    	}    
    //stage('Deploy') {
     //steps{
            //withAWS(credentials: registryCredential, region: "${AWS_DEFAULT_REGION}") {
                //script {
		//	sh './script.sh'
              //  }
            //} 
        }
      }      
      
    }
}

