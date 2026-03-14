variable "firewall" {
    type = map(object({
      subnet_name = string
      virtual_network_name = string
      resource_group_name = string
      pip_name = string
      name = string
      location = string
      sku_name = string
      sku_tier = string
      firewallmgmt_pip = string
      firewallmgmt_subnet = string
      firewallpolicy_name = string
    }))
  
}