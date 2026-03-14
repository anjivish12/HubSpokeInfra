data "azurerm_subnet" "subnet" {
  for_each = var.firewall
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "firewall_pip" {
      for_each = var.firewall

  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "firewallmgmt_subnet" {
  for_each = var.firewall
  name                 = each.value.firewallmgmt_subnet
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}


data "azurerm_public_ip" "firewallmgmt_pip" {
      for_each = var.firewall

  name                = each.value.firewallmgmt_pip
  resource_group_name = each.value.resource_group_name
}

data "azurerm_firewall_policy" "firewallpolicy" {
        for_each = var.firewall

  name                = each.value.firewallpolicy_name
  resource_group_name = each.value.resource_group_name
}