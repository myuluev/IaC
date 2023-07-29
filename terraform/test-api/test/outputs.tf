output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "azurerm_app_service_plan" {
  value = azurerm_app_service_plan.main.name
}
