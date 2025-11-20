# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "vercel-migration-rg"
  location = "East US"
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
# App Service Plan
resource "azurerm_service_plan" "plan" {
  name                = "vercel-migration-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Web App
resource "azurerm_linux_web_app" "app" {
  name                = "vercel-migration-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    linux_fx_version = "NODE|20-lts"
    always_on        = true
    # VNet integration
    vnet_route_all_enabled = true
    subnet_id              = azurerm_subnet.subnet.id
  }

  app_settings = {
    # DATABASE_URL will be injected from Azure DevOps pipeline
    "WEBSITES_PORT" = "3000"
  }
}

# Application Insights
resource "azurerm_application_insights" "ai" {
  name                = "vercel-migration-ai"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

