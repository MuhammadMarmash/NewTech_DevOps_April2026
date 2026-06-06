variable "region" {
  type        = string
  description = "The region to deploy the resources"
  #default     = "us-north-1"
}

variable "ami" {
  type        = string
  description = "The AMI to deploy the resources"
  #default     = "ami-0b5a4e51202cd98e5"
}

variable "instance_type" {
  type        = string
  description = "The instance type to deploy the resources"
  #default     = "t3.micro"
}

variable "ec2_instance_init_code" {
  type = string
  description = "The ec2 instance init code file path"
}

variable "key_name" {
  type = string
  description = "The key name to access the ec2 instance"

}
variable "vpc_security_group_ids" {
  type = list(string)
  description = "The security group ids to attach to the ec2 instance"
}
variable "subnet_id" {
  type = string
  description = "The subnet id to attach to the ec2 instance"
}

variable "name" {
  type = string
  description = "The name of the ec2 instance"

}

variable "availability_zone" {
  type = string
  description = "The availability zone to deploy the ec2 instance"
}
