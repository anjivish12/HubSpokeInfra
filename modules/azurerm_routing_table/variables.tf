variable "routingtable" {
    type = map(object({
      # subnet_name = string
      # virtual_network_name = string
      # rouetable_name = string
      name = string
      location = string
      resource_group_name = string
      route = optional(list(object({
        name           = string
        address_prefix = string
        next_hop_type  = string
        next_hop_in_ip_address = optional(string)
      })))
    }))
}