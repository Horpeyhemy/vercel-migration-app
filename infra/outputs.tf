output "app_service_url" {
  value = azurerm_app_service.app.default_site_hostname
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
