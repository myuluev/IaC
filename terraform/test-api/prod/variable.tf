# staging environment
variable stage {
  description = "Azure stage environment name"
}

# azure region
variable location {
  description = "Azure region where resources will be located"
}

# resource group name
variable rg-name {
  description = "The name of resource group "
}

# sku name for mysql database configuration
variable sku-name {
  description = "Enter the name of the pricing tier"
}

# public network access configuration
variable public-network-access {
  description = "Public network access configuration"
}
