terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.17.0"
    }

    aws = {
      source = "hashicorp/aws"
      version = "~> 5.83.0"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.19.0"
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

provider "helm" {
  kubernetes = {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}

provider "kubectl" {
  apply_retry_count = 3
  host = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  load_config_file = false
  exec = {
   api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }   
}
  