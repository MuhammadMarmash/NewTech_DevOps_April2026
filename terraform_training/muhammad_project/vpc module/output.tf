output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}
