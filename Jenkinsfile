pipeline {
    agent any

    tools {
        maven "Maven"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git credentialsId: '11', url: 'https://github.com/GitAlleks/MVCAndHibernate'
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

            }
        
            post {
                success {
                    sh 'cp $WORKSPACE/target/*.war /webapp/ROOT.war'
                    }
                }
        }
        stage ("Post to S3 bucket") {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "10", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh 'aws s3 ls'
                    sh "aws s3 cp /webapp/ROOT.war s3://app-viper-bucket/app/ROOT${BUILD_TAG}.war"
                }
            }
        }
        // I create another job that triggered by this pipeline job, 
        // the second job use plugin AWSEB Deployment Plugin, that i cant define in this pipeline 
        stage("Deploy to AWS Elastic Beanstalk") {
            steps{
                echo "Use the second job, that triggered by this job "
                echo "That uses plugin AWSEB Deployment Plugin"
                echo "Before start deploy , starts sh script that copy Artifact from this job : cp /webapp/*.war ."
            }
    } 
}