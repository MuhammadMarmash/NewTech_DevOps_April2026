variable "type" {
  type        = string
  description = "The type of the security group rule"
  #default     = "ingress"
}

variable "from_port" {
  type        = number
  description = "The from port of the security group rule"
  #default     = 22

}
variable "to_port" {
  type        = number
  description = "The to port of the security group rule"
  #default     = 22
}
variable "protocol" {
  type        = string
  description = "The protocol of the security group rule"
  #default     = "tcp"
}
variable "cidr_blocks" {
  type        = list(string)
  description = "The cidr blocks of the security group rule"
  default     = null
}

variable "source_security_group_id" {
  type        = string
  description = "The source security group id to allow traffic from"
  default     = null
}
variable "security_group_id" {
  type        = string
  description = "The security group id to attach the security group rule"
  #default     = aws_security_group.allow_ssh.id
}

variable "description" {
  type        = string
  description = "The description of the security group rule"
}
