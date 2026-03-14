module "resource_group" {
  source = "../../modules/azurerm_rg"
  rgs    = var.rgs
}

module "vnet" {
  depends_on = [module.resource_group, module.routingtable]
  source     = "../../modules/azurerm_vnet"
  vnets      = var.vnets
}
module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_public_ip"
  pips       = var.pips
}

module "nsg" {
  depends_on = [module.resource_group, module.vnet]
  source     = "../../modules/azurerm_nsg"
  nsgs       = var.nsgs

}
module "vm" {
  depends_on = [module.resource_group, module.public_ip, module.vnet]
  source     = "../../modules/azurerm_vm"
  vms        = var.vms
}

# module "bastion" {
#   depends_on = [module.vnet, module.public_ip]
#   source     = "../../modules/azurerm_bastion_host"
#   bastion    = var.bastion

# }
module "firewallpolicy" {
  depends_on = [ module.resource_group ]
  source = "../../modules/azurerm_firewall_policy"
  firewallpolicy = var.firewallpolicy
}

module "firewall" {
  depends_on = [ module.public_ip, module.resource_group, module.vnet, module.firewallpolicy]

  source = "../../modules/azurerm_firewall"
  firewall =  var.firewall
  
}

module "firewallrule" {
  depends_on = [ module.firewallpolicy ]
  source = "../../modules/azurerm_firewall_policy_NAT"
  firewallrule = var.firewallrule
}

module "routingtable" {
  depends_on = [ module.resource_group ]
  source = "../../modules/azurerm_routing_table"
  routingtable =  var.routingtable
  
}