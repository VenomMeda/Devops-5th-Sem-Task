module "ec2" {
  source         = "./modules/ec2"
  instance_count = var.instance_count
  subnet_id      = module.vpc.subnet_id
}
