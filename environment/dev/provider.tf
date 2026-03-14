terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
  # backend "azurerm" {}
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = "80a4f419-f341-4500-b253-3fbc8b7b9ea4"
}
