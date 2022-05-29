terraform {
  #required_version = "1.2.1"  #このコードの実行に必要なTerraform本体のバージョン(Productionでは固定するのが望ましい)
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}