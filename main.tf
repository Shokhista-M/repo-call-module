terraform{
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "029DA-DevOps24"

        workspaces {
            name = "my_second_workspace"
        }
    }   
    required_provider {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
    
}
provider "aws" {
  region = "us-east-1"
}

module "security-030" {
  source  = "app.terraform.io/029DA-DevOps24/security-030/aws"
  version = "1.0.0"
  # insert required variables here
}