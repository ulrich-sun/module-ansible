output "ec2_master_public_ip" {
  value = aws_instance.master.public_ip
}

output "ec2_slave_public_ip" {
  value = aws_instance.slave.public_ip
}