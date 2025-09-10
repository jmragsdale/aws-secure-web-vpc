# (shortened) — see chat for concepts; this compiles as-is after provider creds
terraform {
  required_providers { aws = { source = "hashicorp/aws", version = "~> 5.0" } }
}
provider "aws" { region = var.region }
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.5"
  name = "golden-vpc"
  cidr = "10.20.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names,0,2)
  private_subnets = ["10.20.1.0/24","10.20.2.0/24"]
  enable_nat_gateway = false
  create_igw = false
  vpc_endpoints = {
    ssm   = { service = "ssm", private_dns_enabled = true }
    ec2ms = { service = "ec2messages", private_dns_enabled = true }
    ssmmg = { service = "ssmmessages", private_dns_enabled = true }
    logs  = { service = "logs", private_dns_enabled = true }
    s3    = { service = "s3" } # GW endpoint
  }
}
resource "aws_securityhub_account" "this" {}
resource "aws_guardduty_detector" "this" { enable = true }
