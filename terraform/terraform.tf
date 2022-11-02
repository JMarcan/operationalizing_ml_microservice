terraform {
    required_version = "1.3.3"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.37.0"
        }

        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = "2.15.0"
        }
    }

    backend "s3" {
        key             = "state/state.tfstate"
        encrypt         = true
        dynamodb_table  = var.dynamodb_table
    }
}

provider "aws" {
    region = var.aws_region
}