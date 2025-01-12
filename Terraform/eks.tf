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

  provider "aws" {
    region = "us-east-1"
  }

  backend "s3" {
    bucket = "cj-vprofile-s3-storage"
    key    = "terraform.karpenter-tfstate"
    region = "us-east-1"
  }
}