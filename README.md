# AWS Serverless Architecture Project

This project implements a serverless architecture that includes both a backend and a frontend. The backend is responsible for processing requests and manipulating data, while the frontend is a static application served through CloudFront, with high availability and security via HTTPS. The entire infrastructure was provisioned and managed using Terraform.

## Table of Contents
- [Architecture](#architecture)
- [About](#about)
- [How to Use](#how-to-use)

## Architecture

### Backend
![alt text](<images/architecture.drawio.svg>)

- **Route 53**: Manages the routing of requests to the API.
- **API Gateway**: Entry point for requests, responsible for routing, authenticating via Cognito, and forwarding to Lambda functions.
- **Cognito**: Used for user authentication and authorization.
- **Lambda (Node.js)**: Functions responsible for:
  - Performing CRUD operations on DynamoDB.
  - Processing JSON files stored in S3.
  - Responding to SNS and SQS events.
- **S3**: Stores Lambda artifacts and JSON files that trigger Lambda executions.
- **DynamoDB**: NoSQL database used to store system data.
- **SNS**: Notification service used to send messages about processed events.
- **SQS**: Manages message queues, controlling workflow and ensuring message delivery to Lambda functions.
- **CloudWatch**: Used for monitoring, log collection, and alarm configuration.

### Frontend

![alt text](./images/static.drawio.svg)
- **S3**: Stores static files (HTML, CSS, JS) for the frontend.
- **CloudFront**: CDN (Content Delivery Network) used to globally distribute static content with low latency.
- **Certificate Manager**: Generates and manages SSL/TLS certificates to enable HTTPS on CloudFront.
- **Route 53**: Redirects traffic to CloudFront.

## About

The objective of this project is to provision a robust and scalable serverless architecture on AWS, divided into backend and frontend, using a declarative and reproducible approach with Terraform.

The backend was developed using AWS Lambda functions in Node.js to process requests, perform CRUD operations on DynamoDB, and handle JSON files stored in S3. The infrastructure also includes services such as API Gateway for request management, Cognito for authentication, as well as SNS and SQS for event management and message queues.

The frontend consists of a static application, hosted in an S3 bucket and globally distributed via CloudFront, with HTTPS support provided by AWS Certificate Manager. This approach ensures high availability and security for delivering content to end users.

## How to Use

### 1. Clone the repository to your local machine:

```git clone https://github.com/Alves0611/deploy-terraform-serverless-application```


**Prerequisites**: Ensure that you have Terraform installed on your machine and AWS credentials configured.

**Terraform Initialization**: In the project's `terraform` directory, run the following command to initialize Terraform:

```bash
cd <directory-name>

terraform init
```

**Apply the configurations:** To provision the infrastructure, run:

```bash
terraform apply
```

**Destroy the infrastructure:** If you need to remove the provisioned infrastructure, use:

```bash
terraform destroy
```

