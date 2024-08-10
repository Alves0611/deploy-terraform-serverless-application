terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.22.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  backend "s3" {
    bucket         = "tfstate-891377404175"
    key            = "serverless-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tflock-tfstate-891377404175"
  }
}
