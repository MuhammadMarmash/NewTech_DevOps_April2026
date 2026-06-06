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

variable "Web_DMZ_SG_rules" {
  type = list(object({
    type              = string
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_blocks       = list(string)
    description = string
  }))
  description = "List of security group rules to apply to the Web_DMZ_SG security group"
  default     = [{
    description = "https_in"
      type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  },{
    description = "all_out"
      type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  },{
    description = "http_in"
      type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  },{
    description = "ssh_in"
      type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  }]

}

variable "ec2_instances" {
  type = map(number)
  description = "List of EC2 instances to deploy"
  default     = {"EC2-1"=0, "EC2-2"=1}
}
