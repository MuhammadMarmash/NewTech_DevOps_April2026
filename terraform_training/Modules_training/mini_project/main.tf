terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "devopsclassapril26"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}

module "ec2" {
  source = "../EC2 Module"
  ami = var.ami
  instance_type = var.instance_type
  region = var.region
  name = "terraform-training"
}