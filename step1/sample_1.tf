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
