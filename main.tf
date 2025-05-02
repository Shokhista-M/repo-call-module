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
#ç
#            egress_rules = [
#                {
#                    from_port   = 80
#                    to_port     = 80
#                    description = "HTTP"
#                    protocol    = "tcp"
##
#                    #ipv6_cidr_blocks = []
#                }   
#            ]                                      
#        }
#        #this we use in our project for create security groups
#        app_sg : {
#            #name = "app_sg"
#            description = "Security group for application servers"
#            vpc_id = aws_vpc.main.id
#            ingress_rules = [
#                {
#                    from_port   = 443
#                    to_port     = 443
#                    description = "HTTPS"
#                    protocol    = "tcp"
#                    cidr_blocks = []
#                    #ipv6_cidr_blocks = []
#                }   
#            ]                                      
#        }
#    }
#}
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
# we can also create if we don't have any rules created we can use for this step
module "security_groups" {
   source = "./modules/security_group"
   security_group = {
    web_sg : {
      description = " security group for web servers"
      vpc_id = aws_vpc.main.id
      }
      app_sg : {
      description = " security group for app servers"
      vpc_id = aws_vpc.main.id
      }   
   }
} 
output "web_sg_id" {
  value = module.security_groups.security_group.ids["web_sg"]
}
output "app_sg_id" {
  value = module.security_groups.security_group.ids["app_sg"]
}