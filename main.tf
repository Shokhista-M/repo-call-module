terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "029DA-DevOps24"

    workspaces {
      name = "my_second_workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

}
provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Repository = "repo-call-module"
    }
} 
module "security_group" {
    source = "./modules/security_group"
    security_group = {
        web_sg : {
            #name = "web_sg"
            description = "Security group for web servers"
            vpc_id = aws_vpc.main.id
            tags = {
                Name = "web_sg"
            }                                       
        }
    }
}
#module "security-group" {
#    source = "./modules/security_group"
#    vpc_id = aws_vpc.main.id
#    security_group_description = "My first module sg description"
#    security_group_name = "my first module sg"
#    tag = {
#        name = "my first module sg"
#    }
    # insert required variables here
#} this module for 3-5 variables

#module "app_sg" {
#  source  = "app.terraform.io/029DA-DevOps24/security-030/aws"
#  version = "1.0.0"
#  vpc_id = aws_vpc.main.id
# insert required variables here
#}
#module "web_sg" {
#  source  = "app.terraform.io/029DA-DevOps24/security-030/aws"
#  version = "1.0.0"
#  vpc_id = aws_vpc.main.id
#  # insert required variables here
#}