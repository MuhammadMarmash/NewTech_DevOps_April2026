variable "security_group_id" {
  type        = string
  description = "The security group id to attach to the load balancer"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet ids to attach to the load balancer and autoscaling group"
}

variable "vpc_id" {
  type        = string
  description = "The vpc id to attach the target group"
}

variable "launch_template_id" {
  type        = string
  description = "The launch template id to use for the autoscaling group"
}
