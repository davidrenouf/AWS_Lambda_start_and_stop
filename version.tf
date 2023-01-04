terraform {
  required_version = "~> 1.3.0"
  required_providers {
    archive = {
      version = "~> 2.2.0"
      source  = "hashicorp/archive"
    }
    aws = {
      version = "~> 4.0"
      source  = "hashicorp/aws"
    }
  }
}
