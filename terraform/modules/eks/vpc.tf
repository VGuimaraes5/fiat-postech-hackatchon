resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    fiap = "hackathon"
  }

  enable_dns_hostnames = true
  enable_dns_support   = true
}
