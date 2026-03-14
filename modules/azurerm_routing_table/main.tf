resource "azurerm_route_table" "rt" {
  for_each = var.routingtable
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  bgp_route_propagation_enabled = false


  dynamic "route" {
    for_each = each.value.route
    content {
      name           = route.value.name
      address_prefix = route.value.address_prefix
      next_hop_type  = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
      
    }
    
  }

}


# data "azurerm_subnet" "subnet" {
#    for_each = var.routingtable
#   name                 = each.value.subnet_name
#   virtual_network_name = each.value.virtual_network_name
#   resource_group_name  = each.value.resource_group_name
# }

# resource "azurerm_subnet_route_table_association" "subnet_associate" {
#   subnet_id      = data.azurerm_subnet.subnet[each.key].id
#   route_table_id = azurerm_route_table.rt[each.key].id
# }
