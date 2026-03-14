resource "azurerm_firewall_policy" "policy" {
  for_each = var.firewallpolicy
  name                = each.value.firewallpolicy_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
}



