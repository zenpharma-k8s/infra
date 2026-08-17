terraform {
  backend "azurerm" {
    resource_group_name = "demo-rg"
    storage_account_name = "zenpharmatfsa"
    container_name = "zenpharma-tfstate"
    key = "zenpharma-dev.tfstate"
  }
}