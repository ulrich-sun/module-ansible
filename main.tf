
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

module "ansible" {
  source             = "./modules/ansible"
  ami                = data.aws_ami.ubuntu.id
  master_tag         = var.master_tag
  instance_type      = var.instance_type
  sg_tag             = var.sg_tag
  securitygroup_name = var.securitygroup_name
  user               = var.user
  key_name           = var.key_name
  slave_tag          = var.slave_tag
}