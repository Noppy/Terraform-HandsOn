resource "aws_instance" "bastion" {
  ami = data.aws_ssm_parameter.amz2_ami_id.value
  vpc_security_group_ids = [
    var.sg-id
  ]
  key_name                    = var.key_name
  instance_type               = local.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_role.name
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp3"
    volume_size = "8"
  }


  user_data = <<EOF
  #!/bin/bash -xe
  yum -y update
  hostnamectl set-hostname "bastion"
  EOF

  tags = {
    Name = "BastionServer"
  }
}