terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.17.0"
    }

    aws = {
      source = "hashicorp/aws"
      version = "~> 5.82.2"
    }
  }

  backend "s3" {
    bucket = "aws-eks-karpenter-tfstate"
    key    = "terraform.karpenter-tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}