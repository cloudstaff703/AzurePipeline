provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "rgpipeline" {
  name = "rgpipeline"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name = "AKSclusterPipeline"
  location = azurerm_resource_group.rgpipeline.location
  resource_group_name = azurerm_resource_group.rgpipeline.name
  dns_prefix = "myaks"

  default_node_pool {
    name = "default"
    node_count = 2
    vm_size = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_container_registry" "acr" {
  name = "containerRegistryPipeline"
  resource_group_name = azurerm_resource_group.rgpipeline.name
  location = azurerm_resource_group.rgpipeline.location
  sku = "Basic"
  admin_enabled = true
}