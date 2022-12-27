module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"

  name = "abcd"
  cidr = "90.90.0.0/16"

  azs             = ["us-east-1c", "us-east-1d"]
  public_subnets  = ["90.90.10.0/24", "90.90.20.0/24"]
  private_subnets = ["90.90.11.0/24", "90.90.21.0/24"]

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "staging"
  }
}
