instance_type      = "t2.medium"
master_tag         = "ec2_master"
user               = "ubuntu"
key_name           = "aws_key"
securitygroup_name = "ansible-sg"
sg_tag = {
  Name = "ansible-sg"
}
slave_tag = {
  Name = "ec2_slave"
}