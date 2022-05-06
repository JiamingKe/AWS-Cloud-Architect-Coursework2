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
  access_key = "ASIATYHHRLITTTYLCP75"
  secret_key = "JioGj2q0qFDMqrqTi+4MOJPJMJnb+K+bFJz7uDL+"
  token = "FwoGZXIvYXdzEO3//////////wEaDPJZ2gHo/tG3kMKpNyLVAWAMKomUb+ZkVAc3Yv5Uf9wTjfzvdnbTsjJN6MoBN1utQFK0mlifWopej+4du4x0BLYgvHjxpjjH0mR33NDR50lZuJqCLWoZhRez838+CwaEMuY664eB+LeDyztk6Q9YRMUSYat4jZNY1reKrsMAuMHeMfJm/sletaRguF5GmmlKHS2W0AzJUJlctX2Ur2bhIaAwZMIw9zmxOCtgZHoMHx6O8eTwh1p6FJu8Ny+pBRF+SzhZiAghZYgweelxwglCH25FgIUVQLs6PhlqNo5QSHBLySxpAii5h9STBjItgnMl08uBS1g/Zpj1h7kr1hnbI2BQqNHrjGSNK2DHvQgTJIPPveDiobkA/1e3"
  region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  subnet_id   = "subnet-0abf91346e15ed3ca"

  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-0323c3dd2da7fb37d"
  instance_type = "m4.large"
  subnet_id   = "subnet-0abf91346e15ed3ca"

  tags = {
    Name = "Udacity M4"
  }
}
