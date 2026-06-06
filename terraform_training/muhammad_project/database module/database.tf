resource "aws_db_instance" "dbs" {
  count                  = 2
  identifier             = "mydb-${count.index + 1}"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "password1234"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [var.db_sg_id]
}
