terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}


//export AWS_PROFILE=henrym718 ---LINUX BASH
//set AWS_PROFILE=henrym718 ---WINDOWS
