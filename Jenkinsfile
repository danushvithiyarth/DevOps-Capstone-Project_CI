pipeline {
    agent any

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        IMAGE_NAME = "danushvithiyarth/capstoneproject"
        IMAGE_VERSION = "v${env.BUILD_NUMBER}"
    }

    tools {
        maven 'maven-3.11'
        java 'java-11'
    }

    stages {
      stage('Checkout') {
            steps {
                deleteDir()
                git branch: 'main', url: 'https://github.com/danushvithiyarth/DevOps-Capstone-Project_CI.git'
            }
        }

      stage('Install Dependencies') {
            steps {
                sh 'mvn clean install'
            }
        }
      
      stage('SonarQube-analysis') { 
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''
                        ${SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=capstoneproject \
                        -Dsonar.projectName=capstoneproject \
                        -Dsonar.java.binaries=target/classes
                    '''     
                }
            }
        }

      stage('OWASP-check') {
            steps {
                dependencyCheck additionalArguments: '''--scan target/ 
                  --format ALL 
                  --nvdApiKey "13a0de1d-1e66-41d8-bea6-056625bccb01"
                ''', odcInstallation: 'owasp-check'
            }
        }

        stage('Docker Image Build') {
            steps {
                sh 'docker image prune -af'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Trivy-Check') {
           steps {
             script {
                    sh "trivy image --format table -o report.html ${IMAGE_NAME}:${IMAGE_VERSION}"
              }
           }
        }

        stage('DockerHub image push') {
            steps {
                sh "docker rm -f test-application"
                withCredentials([usernamePassword(credentialsId: 'Docker_pass', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} docker.io"
                }
                sh "docker push ${IMAGE_NAME} --all-tags"
            }
        }
      /*
        stage('Git Clone&Update&Push manifest repo') {
            steps {
                echo 'Cloning repo'
                sh 'rm -rf ArgoCd-project-CD_Process'
                sh "git clone https://github.com/danushvithiyarth/ArgoCd-project-CD_Process.git"

                echo 'Updating repo'
                dir("ArgoCd-project-CD_Process/manifest"){
                  sh 'sed -i "s#danushvithiyarth/argocdproject:.*#${IMAGE_NAME}:${IMAGE_VERSION}#g" deployment.yaml'
                  sh 'cat deployment.yaml'

                  echo 'Commiting and Pushing the repo'
                  sh 'git config --global user.name "admin"'
                  sh 'git config --global user.email "abc@gmail.com"'
                  sh 'git add deployment.yaml'
                  sh 'git commit -m "Update image tag to ${IMAGE_NAME}:${IMAGE_VERSION}"'
                  withCredentials([usernamePassword(credentialsId: 'github-cerds', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_TOKEN')]) {
                     sh 'git remote set-url origin https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/danushvithiyarth/ArgoCd-project-CD_Process.git'
                     sh 'git push origin main'
                  }
               }     
            }
        }*/
    }

    post {
        always {
            publishHTML([allowMissing: true, alwaysLinkToLastBuild: true, icon: '', keepAll: true, reportDir: './', 
                         reportFiles: 'dependency-check-jenkins.html', reportName: 'OWASP Report', reportTitles: '', 
                         useWrapperFileDirectly: true])
            publishHTML([allowMissing: true, alwaysLinkToLastBuild: true, icon: '', keepAll: true, reportDir: './',
                         reportFiles: 'report.html', reportName: 'Trivy Report', reportTitles: '', useWrapperFileDirectly: true])
        }
    }
}
