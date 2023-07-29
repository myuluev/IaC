# Configure The Microsoft Azure Provider
provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    mysql = {
      source = "terraform-providers/mysql"
      version = "~> 1.6"
    }
  }
}