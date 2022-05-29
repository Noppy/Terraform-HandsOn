#--------------------------------------------------
# Terraform Setting
# https://www.terraform.io/language/settings
#--------------------------------------------------
terraform {
  #required_version = "1.2.1"  #このコードの実行に必要なTerraform本体のバージョン(Productionでは固定するのが望ましい)
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

#--------------------------------------------------
# Provider Setting
# https://www.terraform.io/language/providers
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
#--------------------------------------------------
provider "aws" {
  profile = "default" #あらかじめ準備しているプロファイル名に変更する
  region  = "ap-northeast-1"
}


#--------------------------------------------------
# Resource Settiong
#https://www.terraform.io/language/resources
#--------------------------------------------------

#AWS IAM Role
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "ec2_instance_role" {
  name = "ec2_instance_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}

#AWS IAM Instance Profile
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ec2_instance_role" {
  name = "ec2_instance_role"
  role = aws_iam_role.ec2_instance_role.name
}

#--------------
# Step2
#--------------
# Input Valiable 
# https://www.terraform.io/language/values/variables
variable "public_subnet_id" {
  type = string
}

variable "sg-id" {
  type = string
}

variable "key_name" {
  type    = string
  default = "CHANGE_KEY_PAIR_NAME"
}

# Input Locals
# https://www.terraform.io/language/values/locals
locals {
  instance_type = "t2.micro"
}

# Data Sources
# https://www.terraform.io/language/data-sources
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter
data "aws_ssm_parameter" "amz2_ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-kernel-5.10-hvm-x86_64-gp2"
}

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