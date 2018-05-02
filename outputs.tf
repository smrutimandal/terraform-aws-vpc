output "vpc_id" {
  description = "Unique ID of the created VPC"
  value       = "${aws_vpc.main_vpc.id}"
}

output "vpc_security_group_id" {
  description = "Unique ID of the security group"
  value       = "${aws_default_security_group.default.id}"
}

output "subnet_id" {
  description = "Unique ID of the private subnet"
  value       = "${aws_subnet.priv_subnet.id}"
}
