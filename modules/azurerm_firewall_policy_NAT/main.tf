data "azurerm_firewall_policy" "firewallpolicy" {
  for_each = var.firewallrule
  name                = each.value.policy_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_firewall_policy_rule_collection_group" "firewallrule" {
   for_each = var.firewallrule
  name               = each.value.rule_name
  firewall_policy_id = data.azurerm_firewall_policy.firewallpolicy[each.key].id
  priority           = 500

  dynamic "network_rule_collection" {
    for_each = each.value.network_rule_collection
    content {
          name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action
      dynamic "rule" {
        for_each = network_rule_collection.value.rule
        content {
            name                  = rule.value.name
            protocols             = rule.value.protocols
            source_addresses      = rule.value.source_addresses
            destination_addresses = rule.value.destination_addresses
            destination_ports     = rule.value.destination_ports
          
        }
      
      }
      
    }

  }

}