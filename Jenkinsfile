pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('Access_Key')   
        AWS_SECRET_ACCESS_KEY = credentials('Secret_ID')   
    }

    stages {
        stage('Print Parameter') {
            steps {
                script {
                    echo "autoApprove parameter value: ${params.autoApprove}"
                }
            }
        }

        stage('Checkout') {
            steps {
                deleteDir()
                git branch: 'main', url: 'https://github.com/danushvithiyarth/DevOps-Capstone-Project_CI.git'
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                dir('Terraform_Script') {
                    sh '''
                        terraform init -input=false
                        terraform fmt -check
                        terraform plan -input=false -out=tfplan
                        terraform show -no-color tfplan > tfplan.txt
                        echo "Preview of Terraform plan:"
                        head -n 30 tfplan.txt
                    '''
                }
            }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }
            steps {
                script {
                    echo "Showing Terraform plan summary before approval..."
                    sh 'head -n 50 DevOps-Capstone-Project_CI/Terraform_Script/tfplan.txt'
                    input message: "Do you want to apply the Terraform plan?"
                }
            }
        }

        stage('Apply') {
            steps {
                dir('Terraform_Script') {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }
}
