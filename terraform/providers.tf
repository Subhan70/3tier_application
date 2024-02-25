terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }

    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.92.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "~> 5.16.0"
    }

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

  backend "s3" {
    bucket = "three-tier-multicloud"
    key    = "terraform.tfstate"
    region = "us-east-1" # This is the AWS default, but can be set to any valid AWS region.
  }

  required_version = "~> 1.6.3"
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}
##
##
##
