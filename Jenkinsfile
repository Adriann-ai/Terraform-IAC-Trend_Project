pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION    = "ap-south-1"
    }

    stages {

        stage("Git Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/Adriann-ai/Terraform-IAC-Trend_Project.git'
            }
        }

        stage("Initialize") {
            steps {
                sh """
                terraform init
                """
            }
        }

        stage("Validate") {
            steps {
                sh """
                terraform validate
                """
            }
        }

        stage("Plan") {
            steps {
                sh """
                terraform plan
                """
            }
        }

        stage("Apply") {
            steps {
                sh """
                terraform apply -auto-approve
                """
            }
        }

    }
}
