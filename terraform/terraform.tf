terraform {
    required_version = "1.3.3"

    required_providers {
    aws = {
        version = "4.37.0"
    }

    backend "s3" {
        key     = "state/state.tfstate"
        encrypt = true
    }
    }
}

provider "aws" {
    region = var.aws_region
}