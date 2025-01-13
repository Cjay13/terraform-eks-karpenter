data "aws_ssm_parameter" "bottle_rocket_image_id" {
  name = "/aws/service/bottlerocket/aws-k8s-${var.eks-version}/x86_64/latest/image_id"
}

data "aws_ami" "bottlerocket_ami" {
  owners = ["amazon"]
  filter {
    name = "image-id"
    values = [data.aws_ssm_parameter.bottle_rocket_image_id.value]
  }
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name = var.cluster_name
  cluster_version = var.eks-version

  cluster_addons = {
    coredns = {}
    eks-pod-identity-agent = {}
    kube-proxy = {}
    vpc-cni = {}
  }

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    ng1 = {
      ami_id = data.aws_ami.bottlerocket_ami.id
      instance_type = var.instance_size

      min_size = var.max_size
      max_size = var.max_size
      desired_size = var.desired_size
    }
  }
}