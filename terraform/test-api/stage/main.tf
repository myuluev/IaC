# Azure Provider source
terraform {
  backend "azurerm" {
  }
}

# Created a resources group
resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.location

  tags = {
    environment = var.stage
  }
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "log-analytics-${var.stage}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_app_service_plan" "main" {
  name                = "asp-B1-west-europe-api-linux-${var.stage}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_app_service" "test_api" {
  name                = "test-api-${var.stage}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    app_command_line = "gunicorn --config configuration/gunicorn.ini app:app"
    linux_fx_version = "PYTHON|3.8"
    #always_on        = "true"
    min_tls_version  = "1.2"
    ftps_state       = "Disabled"
  }

  auth_settings {
    enabled = false
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "PROMETHEUS_MULTIPROC_DIR"       = "tmp"
  }

  depends_on = [azurerm_app_service_plan.main]
}

