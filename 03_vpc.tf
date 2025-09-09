module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr
  project_name = var.project_name
  engineer = var.engineer
  project_code =  var.project_code
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
  int_cidr = var.int_cidr
} 