# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "vercel-migration-rg"
  location = "Canada Central"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vercel-migration-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Service Plan (Linux)
resource "azurerm_service_plan" "plan" {
  name                = "vercel-migration-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name  
  os_type             = "Linux"
  sku_name            = "S1"
}

# Linux Web App
resource "azurerm_linux_web_app" "app" {
  name                = "vercel-migration-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id 

  site_config { 
    always_on = false
  }
 
  app_settings = {
    # DATABASE_URL will be injected from Azure DevOps variable group
    "WEBSITES_PORT" = "3000"
  }
}


 

