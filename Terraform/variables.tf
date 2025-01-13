variable "eks-version" {
  type = string
  description = "Kubernetes version to be used for the EKS cluster"
  default = "1.31"
}


variable "cluster_name" {
  type = string
  description = "Name of the EKS cluster"
  default = "eks-carpenter"
}


variable "instance_size" {
  type        = list(string)
  description = "The size of instances in this node group"
  default     = ["m5.large"]
}


variable "min_size" {
  type = number
  description = "Minimum number of required nodes"
  default = 2
}


variable "max_size" {
  type = number
  description = "Maximum number of required nodes"
  default = 4
}


variable "desired_size" {
  type = number
  description = "Desired number of required nodes"
  default = 2
}

