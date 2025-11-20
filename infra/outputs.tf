output "app_service_url" { 
  description = "URL of the Azure Web App"
  value       = "https://${azurerm_linux_web_app.app.name}.azurewebsites.net"
}
