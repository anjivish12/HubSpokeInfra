variable "firewallrule" {
    type = map(object({
        policy_name = string
        rule_name = string
        resource_group_name = string
        network_rule_collection = list(object({
        name = string
        priority = number
        action = string
        rule = list(object({
          name = string
          protocols = list(string)
          source_addresses = list(string)
          destination_addresses = list(string)
          destination_ports = list(string)
        }))
      }))
    }))
  
}