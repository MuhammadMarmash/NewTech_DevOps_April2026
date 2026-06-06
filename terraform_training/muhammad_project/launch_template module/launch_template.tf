resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template-"
  image_id      = var.ami
  instance_type = var.instance_type

  user_data = file(var.ec2_instance_init_code)

  key_name = var.key_name

  network_interfaces {
    security_groups = [var.security_group_id]
    subnet_id       = var.subnet_id
  }
}
