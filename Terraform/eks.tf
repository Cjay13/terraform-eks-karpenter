data "aws_ami" "bottlerocket_ami" {
  most_recent = true
  name_regex = "bottlerocket-aws-k8s-\\d+-x86_64-*"

}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name = "var.cluster_name"
  cluster_version = "1.31"

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
      ami_type = data.aws_ami.bottlerocket_ami.id
      instance_type = ["t3.small"]

      min_size = 2
      max_size = 3
      desired_size = 2
    }
  }


}