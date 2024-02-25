terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
  }

 # backend "s3" {
 #   bucket = "three-tier-multicloud"
 #   key    = "terraform.tfstate"
 #   region = "us-east-1" # This is the AWS default, but can be set to any valid AWS region.
 # }

  required_version = "~> 1.8.0-alpha20240216"
}
##
##
##
