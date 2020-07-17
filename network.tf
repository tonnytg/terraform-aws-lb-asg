# Utilizei o Modulo de VPC
# Fonte: https://github.com/terraform-aws-modules/terraform-aws-vpc
module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git"
  # Change your VPC Name or CIDR
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  # Choose 2 or 3 AZs to have a resilience
  azs            = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
}