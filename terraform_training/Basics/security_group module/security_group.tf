resource "aws_security_group" "Web_DMZ_SG" {
  name   = "Web_DMZ_SG"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "db_sg" {
  name   = "db_sg"
  vpc_id = var.vpc_id
}
