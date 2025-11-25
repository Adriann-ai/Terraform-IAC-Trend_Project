pipeline {
    agent any

    stages {

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
