

resource "aws_instance" "master" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = var.master_tag
  }
  security_groups = ["${var.securitygroup_name}"]
  depends_on      = [aws_instance.slave]
  provisioner "remote-exec" {
    scripts = [ "../file/ansible.sh", "../file/docker.sh" ]
    connection {
      type        = "ssh"
      user        = var.user
      host        = self.public_ip
      private_key = file("../file/${var.key_name}.pem")
    }
  }
  provisioner "local-exec" {
    command = "echo 'master - ${self.public_ip}' >> ./file/public_ip.txt"
    interpreter = [ "cmd", "/c" ]
  }
}
resource "aws_instance" "slave" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = var.slave_tag
  security_groups = ["${var.securitygroup_name}"]
  provisioner "local-exec" {
    command = "echo slave - ${self.public_ip} >> ./file/public_ip.txt"
    interpreter = [ "cmd", "/c" ]
  }
}
resource "aws_security_group" "sg" {
  name        = var.securitygroup_name
  description = "Allow TLS, HTTP, SSH, and HTTPS traffic"
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = var.sg_tag
}
