# GlobalMart CI/CD Deployment Project

## Project Overview

GlobalMart is a simulated e-commerce company that needs a reliable deployment process for its product catalog application. The goal of this project was to build an automated CI/CD pipeline that deploys a React application to an AWS EC2 instance using modern DevOps tools and Infrastructure as Code.

The infrastructure was provisioned with Terraform, while GitHub Actions was used to automate the build and deployment process. Instead of manually SSHing into the server, the deployment uses AWS Systems Manager Run Command to remotely execute deployment commands on the EC2 instance.

## Architecture

The deployment flow works as follows:

```text
Developer pushes code to GitHub
        |
        v
GitHub Actions workflow starts
        |
        v
React app is built with npm
        |
        v
Build artifact is zipped
        |
        v
Artifact is uploaded to Amazon S3
        |
        v
AWS Systems Manager sends deployment commands to EC2
        |
        v
EC2 downloads artifact from S3
        |
        v
Nginx serves the React application
```

## Services and Tools Used

* Terraform
* GitHub Actions
* AWS IAM
* GitHub OIDC
* Amazon EC2
* Amazon S3
* AWS Systems Manager
* Security Groups
* Nginx
* Amazon Linux 2023
* React
* Node.js and npm

## What Terraform Creates

Terraform provisions the main AWS infrastructure required for the project:

* EC2 instance running Amazon Linux 2023
* Security group allowing HTTP traffic on port 80
* IAM role for EC2 with S3 read and SSM permissions
* S3 bucket for deployment artifacts
* GitHub OIDC provider
* IAM role for GitHub Actions
* IAM policy allowing GitHub Actions to upload artifacts to S3 and trigger SSM commands

## CI/CD Workflow

The GitHub Actions workflow runs automatically when code is pushed to the `main` branch.

The workflow performs these steps:

1. Checks out the repository
2. Installs Node.js
3. Installs project dependencies
4. Builds the React application
5. Zips the build folder
6. Authenticates to AWS using GitHub OIDC
7. Uploads the artifact to S3
8. Finds the running EC2 instance by tag
9. Uses AWS Systems Manager Run Command to deploy the app
10. Restarts Nginx to serve the updated application

## Why I Used AWS Systems Manager Instead of CodeDeploy

The original project idea used AWS CodeDeploy, but I redesigned the deployment process to use AWS Systems Manager Run Command. This simplified the architecture and removed the need to manage a CodeDeploy agent.

Using SSM also improves security because deployments can happen without opening SSH access or manually connecting to the instance.

## Key Troubleshooting Performed

During the project, I resolved several real-world DevOps issues:

* Fixed Terraform errors related to undeclared variables and data sources
* Corrected an IPv6 address issue in an IPv4 security group rule
* Migrated the EC2 instance from Amazon Linux 2 to Amazon Linux 2023
* Fixed user data commands by using `dnf` instead of Amazon Linux 2 package commands
* Resolved GitHub push failure caused by accidentally tracking Terraform provider files
* Added `.gitignore` to exclude `.terraform`, `node_modules`, build files, state files, and local variables
* Fixed GitHub Actions React build failure caused by CI treating warnings as errors
* Fixed GitHub OIDC authorization by correcting the IAM trust policy repository name
* Fixed S3 artifact upload failure caused by a placeholder bucket name
* Debugged SSM deployment failure by checking command invocation output
* Fixed GitHub Actions YAML indentation and syntax issues

## Final Result

The final result is a working automated deployment pipeline.

When code is pushed to GitHub, the pipeline automatically builds the React application and deploys it to an EC2 instance running Nginx.

This project demonstrates hands-on experience with cloud infrastructure, CI/CD automation, IAM permissions, secure AWS authentication, and troubleshooting deployment failures.
Broken trigger test Fri Jul 10 20:01:59 CST 2026
OIDC IAM troubleshooting test Fri Jul 10 20:53:25 CST 2026
OIDC IAM troubleshooting test Fri Jul 10 20:59:16 CST 2026
S3 permission troubleshooting test Fri Jul 10 21:50:01 CST 2026
S3 permission troubleshooting test Fri Jul 10 21:56:01 CST 2026
SSM permission troubleshooting test Fri Jul 10 22:10:40 CST 2026
SSM agent offline troubleshooting test Fri Jul 10 22:35:08 CST 2026
