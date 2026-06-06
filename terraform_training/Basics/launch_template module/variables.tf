variable "ami" {
  type        = string
  description = "The AMI to deploy the resources"
}

variable "instance_type" {
  type        = string
  description = "The instance type to deploy the resources"
}

variable "ec2_instance_init_code" {
  type        = string
  description = "The ec2 instance init code file path"
}

variable "key_name" {
  type        = string
  description = "The key name to access the ec2 instance"
}

variable "security_group_id" {
  type        = string
  description = "The security group id to attach to the launch template"
}

variable "subnet_id" {
  type        = string
  description = "The subnet id to attach to the launch template"
}
