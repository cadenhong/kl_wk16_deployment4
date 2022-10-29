# Deployment 4: Deploy a Flask Application to a Custom VPC Using Terraform

#### Assignment instructions can be found here: [Deployment4_Instructions.pdf](https://github.com/cadenhong/kl_wk16_deployment4/blob/main/Deployment-4_Assignment.pdf)

## Tasks
- Complete the deployment based on provided instructions
- Include additions made from Deployment 3 to the pipeline
- Document steps taken and any observations made (see [Deployment4_Documentation.pdf](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/documentations/Deployment4_Documentation.pdf))
- Diagram the deployment pipeline (see [Deployment4_Diagram.png](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/documentations/Deployment4_Diagram.png))

## Deployment Steps
1. Set up a Jenkins server (EC2 with Ubuntu AMI and ports 22, 80, and 8080; SSH into the EC2 and run [setup_jenkins.sh](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/setup_scripts/setup_jenkins.sh) to install Jenkins)
2. Install Terraform on the Jenkins server using [setup_terraform.sh](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/setup_scripts/setup_terraform.sh)
3. Configure Jenkins Global Credentials using existing AWS IAM user's access key and secret key
<img width="450" alt="image" src="https://user-images.githubusercontent.com/83370640/198817234-5856cc7c-da42-49e7-af10-065d673cf221.png">

4. Set up a [Terraform workspace](https://github.com/cadenhong/kl_wk16_deployment4/tree/main/dp4_terraform/aws_infra) with necessary directories and files to create a VPC
<img width="484" alt="image" src="https://user-images.githubusercontent.com/83370640/198817446-ec06c2f8-dfc2-40c1-911a-b9308bfe2eef.png">

5. Push the Terraform workspace to the same repository as the Flask application
6. Create a Jenkins pipeline using [that GitHub repository](https://github.com/cadenhong/kl_wk14_deployment4)
7. Build and deploy the url-shortener application on your custom VPC:
<img width="542" alt="image" src="https://user-images.githubusercontent.com/83370640/198817909-c1835ef5-686f-45a2-9dd7-6cde2f50f975.png">
<img width="470" alt="image" src="https://user-images.githubusercontent.com/83370640/198817930-2bbe9cfb-b444-4ff0-a5df-6c7e62afb0fa.png">

## Modifications Made (from Deployment 3)
#### Since Slack integration ended for the Kura Labs workspace, I installed the "Email Extension Plugin" on Jenkins and implemented an e-mail notification service to replace the build status alerts.

An email notification will be sent out with the build information and URL regardless of build status after completion:
<img width="542" alt="image" src="https://user-images.githubusercontent.com/83370640/198817710-e72fa012-e126-4210-a004-20485d32bd30.png">

Code added inside Jenkinsfile:
```
     post {
        always {
          emailext to: "caden.p.hong@gmail.com",
            subject: "Jenkins Alert for ${currentBuild.projectName} - Build ${currentBuild.number} Result",
            body: "Confirming that build ${currentBuild.number} has been completed for ${currentBuild.projectName} with a result of ${currentBuild.result}.\n\nFor more information, please visit ${env.BUILD_URL} for details on the build."
            }
     }
```

## Files and Folders
#### [documentations](https://github.com/cadenhong/kl_wk16_deployment4_organized/tree/main/documentations)
- [Deployment4_Diagram.png](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/documentations/Deployment4_Diagram.png): Diagram of the pipeline
- [Deployment4_Documentation.docx](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/documentations/Deployment4_Documentation.docx): Word file of notes and observations made during deployment
- [Deployment4_Documentation.pdf](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/documentations/Deployment4_Documentation.pdf): PDF of notes and observations made during deployment
</details>
  
#### [pipeline_items](https://github.com/cadenhong/kl_wk16_deployment4_organized/tree/main/pipeline_items)
- [dp4_terraform/aws_infra](https://github.com/cadenhong/kl_wk16_deployment4_organized/tree/main/pipeline_items/dp4_terraform/aws_infra): Directory containing Terraform modules and resources to create custom VPC
- [Jenkinsfile](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/pipeline_items/Jenkinsfile): File that defines the deployment pipeline

#### [setup_scripts](https://github.com/cadenhong/kl_wk16_deployment4_organized/tree/main/setup_scripts)
- [setup_jenkins.sh](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/setup_scripts/setup_jenkins.sh): Bash script to setup and install Jenkins
- [setup_terraform.sh](https://github.com/cadenhong/kl_wk16_deployment4_organized/blob/main/setup_scripts/setup_terraform.sh): Bash script to setup and install Terraform

##### [.gitignore](https://github.com/cadenhong/kl_wk14_deployment3_organized/blob/main/.gitignore): List of files to ignore when pushing to GitHub repository

## Tools
- Terraform (infrastructure as code)
- Jenkins (CI/CD pipeline management, email configuration)
- GitHub (repository, access tokens)
- Software Application Stack: Python, Flask, Gunicorn
- AWS VPC (VPC, subnets, internet gateway, route tables)
- AWS EC2 (security groups)
- Diagrams.net (systems design)
