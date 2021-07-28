###CREATE INSTANCES
resource "aws_instance" "dip_instance_1" {
  ami = "ami-0233c2d874b811deb"
  instance_type = "t2.micro"
  key_name = "doom_key"
  subnet_id = aws_subnet.dip_net_1.id
  private_ip = "10.10.3.100"
  associate_public_ip_address = true
  security_groups = [aws_security_group.dip_sc.id]
  user_data = file("source/user_data")

  tags = {
    Name = "dip_int_1"
  }
}

resource "aws_instance" "dip_instance_2" {
  ami = "ami-0233c2d874b811deb"
  instance_type = "t2.micro"
  key_name = "doom_key"
  subnet_id = aws_subnet.dip_net_2.id
  private_ip = "10.10.4.100"
  associate_public_ip_address = true
  security_groups = [aws_security_group.dip_sc.id]
  user_data = file("source/user_data")

  tags = {
    Name = "dip_int_2"
  }
}

resource "aws_instance" "jenk_instance" {
  ami = "ami-0233c2d874b811deb"
  instance_type = "t2.micro"
  key_name = "doom_key"
  subnet_id = aws_subnet.dip_net_3.id
  private_ip = "10.10.5.100"
  associate_public_ip_address = true
  security_groups = [aws_security_group.dip_sc.id]
  iam_instance_profile  = aws_iam_instance_profile.dip_rw_s3_profile.name

  tags = {
    Name = "Jenk"
  }

  provisioner "remote-exec" {
    inline = ["echo Ok"]

    connection {
      host = self.public_ip
      type = "ssh"
      user = "ec2-user"
      private_key = file("${path.module}/source/doom_key.pem")
    }
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/source"
    command = "ansible-playbook -i '${self.public_ip},' --extra-vars 'bucket=${aws_s3_bucket.dip_bucket.bucket}' deploy_docker_jenk.yml"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/source"
    command = "bash update_git_hook ${self.public_ip}"
  }

}