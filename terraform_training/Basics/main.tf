# -----------------------------
# Terraform / Providers
# -----------------------------
terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}


# -----------------------------
# Networking: VPC, Subnets, IGW
# -----------------------------
module "vpc" {
  source = "./vpc module"
}


# -----------------------------
# Security: security groups & rule modules
# -----------------------------
module "security_group" {
  source = "./security_group module"
  vpc_id = module.vpc.vpc_id
}

module "Web_DMZ_SG_rules" {
  source = "./security_group_rule module"
  for_each = { for net in var.Web_DMZ_SG_rules : net.description => net }
  type = each.value.type
  from_port = each.value.from_port
  to_port = each.value.to_port
  protocol = each.value.protocol
  cidr_blocks = each.value.cidr_blocks
  security_group_id = module.security_group.web_dmz_sg_id
  description = each.value.description
}

module "db_sg_rules" {
  source = "./security_group_rule module"
  for_each = {
    "mysql_in" = {
      type        = "ingress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [module.security_group.web_dmz_sg_cidr_blocks[0]]
    }
  }
  type = each.value.type
  from_port = each.value.from_port
  to_port = each.value.to_port
  protocol = each.value.protocol
  cidr_blocks = each.value.cidr_blocks
  security_group_id = module.security_group.db_sg_id
  description = each.key
}


# -----------------------------
# Key pair & local files
# -----------------------------
module "key_pair" {
  source = "./key_pair module"
}


# -----------------------------
# Compute: EC2 modules, launch template
# -----------------------------
module "ec2" {
  source = "./ec2 module"
  for_each = var.ec2_instances
  region                   = var.region
  ami                      = var.ami
  instance_type            = var.instance_type
  ec2_instance_init_code   = var.ec2_instance_init_code
  key_name = module.key_pair.key_name
  vpc_security_group_ids = [module.security_group.web_dmz_sg_id]
  subnet_id = module.vpc.subnet_ids[each.value]
  name = each.key
  availability_zone = module.vpc.availability_zones[each.value]
}

module "launch_template" {
  source = "./launch_template module"
  ami                    = var.ami
  instance_type          = var.instance_type
  ec2_instance_init_code = var.ec2_instance_init_code
  key_name               = module.key_pair.key_name
  security_group_id      = module.security_group.web_dmz_sg_id
  subnet_id              = module.vpc.subnet_ids[0]
}


# -----------------------------
# Load balancer & autoscaling
# -----------------------------
module "load_balancer" {
  source = "./load_balancer module"
  security_group_id  = module.security_group.web_dmz_sg_id
  subnet_ids         = module.vpc.subnet_ids
  vpc_id             = module.vpc.vpc_id
  launch_template_id = module.launch_template.launch_template_id
}


# -----------------------------
# Databases
# -----------------------------
module "database" {
  source = "./database module"
  db_sg_id = module.security_group.db_sg_id
}


# -----------------------------
# Storage: S3 buckets
# -----------------------------
module "s3" {
  source = "./s3 module"
}


# -----------------------------
# CDN: CloudFront
# -----------------------------
module "cloudfront" {
  source = "./cloudfront module"
  origin_domain_name = module.s3.media_assets_domain_name
}
