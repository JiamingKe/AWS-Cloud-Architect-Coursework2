# TODO: Designate a cloud provider, region, and credentials
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.57"
    }
  }
}

provider "aws" {
  access_key = "ASIATYHHRLITZ2DX4BMV"
  secret_key = "/YJHjJJdStZMCEb9L1J6nnxM1AcYWrSF0TjsHX1e"
  token = "FwoGZXIvYXdzELr//////////wEaDI/1NZKe8QJ6WxCrqSLVAZAwzD4raGL6fIcehlTU0AiAzxUQiGabUGKw6Rx3zjPk9az/n1GaY1vIOiF5NtkUlQJWf9Y/ROXtci7G9Lv0KoBM1X7IPE3ljcBC3/Sse1h6xUsXhhnJfRmPuliIZc+N+uGxL5FCoQNsOUXSCR+j180ILwRtxKBdq4Gxz+WHEmG4LbOQZgywxYXy2CoCY2HDPEcMTh0I6feMTaU4rF6tS6NS0KEOhF6D+E5GSdga494B+3ffQSkrLHd7ydvpLg8HRTYOpJ8/7JEn0N0E7p5NajBAxYvQfyiu+8iTBjItvrzPkXZERMwUTv2dzNKL1QNQtYy4jjBZCj1V8o16nd+SLpWJroVv0+MKeCqk"
  region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  subnet_id   = "subnet-06e53470a45402bd4"

  tags = {
    name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-0323c3dd2da7fb37d"
  instance_type = "m4.large"
  subnet_id   = "subnet-06e53470a45402bd4"

  tags = {
    name = "Udacity M4"
  }
}
