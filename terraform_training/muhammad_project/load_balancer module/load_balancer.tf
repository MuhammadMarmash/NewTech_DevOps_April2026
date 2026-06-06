resource "aws_lb" "main" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet_ids[0], var.subnet_ids[1]]
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity    = 2
  max_size            = 5
  min_size            = 1
  vpc_zone_identifier = [var.subnet_ids[0], var.subnet_ids[1]] # Subnets for instances
  target_group_arns   = [aws_lb_target_group.app_tg.arn]

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
}
