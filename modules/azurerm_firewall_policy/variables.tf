variable "firewallpolicy" {
    type = map(object({
      firewallpolicy_name = string
      resource_group_name = string
      location = string 
      
    }))
}