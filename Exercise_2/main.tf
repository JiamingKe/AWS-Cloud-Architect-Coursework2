#TODO: AWS as the provider, and IAM role for Lambda, a VPC, and a public subnet
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
  region = var.aws_region
}

#TODO: IAM role for Lambda
resource "aws_iam_role" "hello_world_iam_role" {
  name = "hello_world_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    name = "ucadity-terraform-exercise-2"
  }
}


resource "aws_iam_policy" "hello_world_iam_policy" {
  name = "hello_world_iam_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action":[
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "hello_world_policy_attachment" {
  role       = aws_iam_role.hello_world_iam_role.name
  policy_arn = aws_iam_policy.hello_world_iam_policy.arn
}

#TODO: A VPC
resource "aws_vpc" "hello_world_vpc" {
  cidr_block = "10.2.0.0/16"

  tags = {
    name = "ucadity-terraform-exercise-2"
  }
}

#TODO: A public subnet
resource "aws_subnet" "hello_world_subnet" {
  vpc_id            = aws_vpc.hello_world_vpc.id
  cidr_block        = "10.2.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    name = "ucadity-terraform-exercise-2"
  }
}

#TODO: The lambda function
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.py.zip"
}

resource "aws_lambda_function" "hello_world_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.lambda.output_path
  function_name = "hello_world"
  role          = aws_iam_role.hello_world_iam_role.arn
  handler       = "lambda.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(data.archive_file.lambda.output_path)

  runtime = "python3.8"
}
