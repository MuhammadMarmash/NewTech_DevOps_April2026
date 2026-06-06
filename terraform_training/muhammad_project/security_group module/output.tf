output "web_dmz_sg_id" {
  value = aws_security_group.Web_DMZ_SG.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
