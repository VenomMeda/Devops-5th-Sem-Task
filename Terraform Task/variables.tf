variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  default     = 2
}
