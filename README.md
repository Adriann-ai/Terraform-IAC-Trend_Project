Overview

      This project demonstrates Infrastructure as Code (IaC) using Terraform and Jenkins to automate the provisioning of AWS resources. The pipeline launches an EC2 instance, sets up required networking, IAM user, and demonstrates how Terraform can be integrated with Jenkins for CI/CD automation.

Features

    Launch an AWS EC2 instance with a public IP

Create networking resources:

        VPC
        
        Subnet
        
        Internet Gateway
        
        Route Table & Route Table Association
        
        Create an IAM user with a login profile

      Full Terraform automation for AWS infrastructure
      
      Integration with Jenkins pipeline for CI/CD
      
      Output sensitive data (IAM user console password) securely

Prerequisites

   
        Jenkins server (installed on an EC2 instance)
        
        Java installed on Jenkins server (required by Jenkins)
        
        Terraform installed on Jenkins server
        
        GitHub repository to store Terraform files and Jenkinsfile

Installation Instructions
  1. Launch an EC2 instance (for Jenkins)

        Install Java:
        
                sudo apt update
                sudo apt install fontconfig openjdk-21-jre
                java -version


        Install Terraform:
        
                sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
                curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                sudo apt-get update && sudo apt-get install terraform -y


        Install Jenkins:
        
              Followed Jenkins official documentation for cmds
.

2. Configure Jenkins

      Open Jenkins UI and install required plugins:

            Terraform
            
            Git

      Configure AWS credentials in Jenkins:

          Add Username/Password credential:
          
          Username → AWS_ACCESS_KEY_ID
          
          Password → AWS_SECRET_ACCESS_KEY
          
          ID → aws-access-key and aws-secret-key
          
          Configure Terraform environment variables in Jenkins pipeline.

Terraform Files
        main.tf
        
              Contains all Terraform configurations:
              
              Terraform block & AWS provider

  Resources:

        VPC
        
        Subnet
        
        Internet Gateway
        
        Route Table
        
        Route Table Association
        
        EC2 instance
        
        IAM user and login profile

output.tf

      Outputs sensitive IAM user password securely:
      
              output "console_password" {
                value     = aws_iam_user_login_profile.user_login.password
                sensitive = true
              }

Jenkinsfile

    Automates Terraform deployment:

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
                              sh 'terraform init'
                          }
                      }
              
                      stage("Validate") {
                          steps {
                              sh 'terraform validate'
                          }
                      }
              
                      stage("Plan") {
                          steps {
                              sh 'terraform plan'
                          }
                      }
              
                      stage("Apply") {
                          steps {
                              sh 'terraform apply -auto-approve'
                          }
                      }
              
                  }
              }

Workflow

        Files pushed from local machine → GitHub repository.
        
        Webhook triggers Jenkins pipeline automatically.
        
        Jenkins runs the pipeline:
        
        Clones repository
        
        Runs terraform init, validate, plan, apply
        
        AWS infrastructure is created automatically.

Outputs

       IAM User console password (sensitive)


      
     
   
