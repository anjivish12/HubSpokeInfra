

resource "azurerm_firewall" "firewall" {
    for_each = var.firewall
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier
  firewall_policy_id  = data.azurerm_firewall_policy.firewallpolicy[each.key].id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.firewall_pip[each.key].id
  }
  management_ip_configuration  {
    name= "firewallmgmt"
    subnet_id = data.azurerm_subnet.firewallmgmt_subnet[each.key].id
    public_ip_address_id  = data.azurerm_public_ip.firewallmgmt_pip[each.key].id
  }
}
