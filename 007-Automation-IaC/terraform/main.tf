terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.53.0"
    }
  }
}

provider "azuread" {
  tenant_id = "1f30af42-6261-4c3a-a437-30b2db0e429f"
}