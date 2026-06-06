resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  region        = var.region
  key_name      = var.key_name

  # lifecycle {
  #   replace_triggered_by = [aws_key_pair.my_key.id]
  # }

  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = file(var.ec2_instance_init_code)

  subnet_id = var.subnet_id

  availability_zone = var.availability_zone

  tags = {
    Name = var.name
  }
}
