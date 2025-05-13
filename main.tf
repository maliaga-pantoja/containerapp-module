data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
resource "azurerm_container_app_environment" "environment01" {
  name                       = local.env_name
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  log_analytics_workspace_id = var.law_id
}

resource "azurerm_container_app" "container01" {
  name                         = local.cap_name
  container_app_environment_id = azurerm_container_app_environment.environment01.id
  resource_group_name          = data.azurerm_resource_group.rg.name
  revision_mode                = "Single"
  ingress {
    target_port = 80
    traffic_weight {
      percentage =  100
    }
  }
  template {
    container {
      name   = "nginxcontainer"
      image  = "nginx"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}