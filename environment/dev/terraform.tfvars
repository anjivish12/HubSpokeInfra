rgs = {
  rg1 = {
    name       = "HS-anjali1"
    location   = "West US"
  }
}

vnets = {
  hub_vnet1 = {
    rouetable_name = "Hub-RoutingTable"
    name                = "Hub-vnet"
    resource_group_name = "HS-anjali1"
    location            = "West US"
    address_space       = ["10.0.0.0/16"]
    subnet = [
      # {
      #   subnet_name      = "AzureBastionSubnet"
      #   address_prefixes = ["10.0.23.0/26"]

      # },
      {
        subnet_name      = "AzureFirewallSubnet"
        address_prefixes = ["10.0.26.0/26"]

      },
      {
        subnet_name      = "AzureFirewallManagementSubnet"
        address_prefixes = ["10.0.29.0/26"]

      }

    ]

  }

  spoke_vnet1 = {
    rouetable_name = "Hub-RoutingTable"
    name                = "spoke1"
    resource_group_name = "HS-anjali1"
    location            = "West US"
    address_space       = ["10.11.0.0/16"]
    subnet = [
      {
      subnet_name = "subnet1"
      address_prefixes = ["10.11.0.0/24"]
    }
      
    ]

  }

  spoke_vnet2 = {
    rouetable_name = "Hub-RoutingTable"
    name                = "spoke2"
    resource_group_name = "HS-anjali1"
    location            = "West US"
    address_space       = ["10.233.0.0/16"]
    subnet = [
      {
        subnet_name = "subnet2"
        address_prefixes = ["10.233.0.0/24"]

      }
    ]
  }
}

pips = {
  # bastion_pip = {
  #   name                = "bastion-pip"
  #   resource_group_name = "HS-anjali1"
  #   location            = "West US"
  #   allocation_method   = "Static"

  # }
  pip2 = {
    name                = "firewall-pip"
    resource_group_name = "HS-anjali1"
    location            = "West US"
    allocation_method   = "Static"

  }
  pip3 = {
    name                = "firewallmgmt-pip"
    resource_group_name = "HS-anjali1"
    location            = "West US"
    allocation_method   = "Static"

  }
  vm1_pip = {
    name                = "vm-pip"
    resource_group_name = "HS-anjali1"
    location            = "West US"
    allocation_method   = "Static"

  }
}

# bastion = {
#   bastion1 = {

#     subnet_name          = "AzureBastionSubnet"
#     virtual_network_name = "Hub-vnet"
#     pip_name             = "bastion-pip"

#     name                = "hub-bastion"
#     location            = "West US"
#     resource_group_name = "HS-anjali1"
#     ip_configuration = [
#       {
#         name = "configuration"

#       }
#     ]
#   }

# }



firewall = {
  hub_firewall = {
      subnet_name = "AzureFirewallSubnet"
      virtual_network_name = "Hub-vnet"
      resource_group_name = "HS-anjali1"
      pip_name = "firewall-pip"
      name = "Hub-firewall"
      location = "West US"
      sku_name = "AZFW_VNet"
      sku_tier = "Premium"
      firewallmgmt_pip = "firewallmgmt-pip"
      firewallmgmt_subnet = "AzureFirewallManagementSubnet"
      firewallpolicy_name = "firewall-policy"
     
  }
}

firewallpolicy = {
  policy1 = {
    firewallpolicy_name = "firewall-policy"
    location = "West US"
    resource_group_name = "HS-anjali1"

  }
}

firewallrule = {
  rule1 = {
    policy_name = "firewall-policy"
    rule_name = "firewall-rule"
    resource_group_name = "HS-anjali1"

    network_rule_collection = [{
      
      name = "nat_rule_collection1"
      priority = 800
      action = "Allow"
      rule = [ {
        name = "spoke1-to-spoke2"
        source_addresses = [ "10.11.0.0/16" ]
        destination_addresses = [ "10.233.0.0/16" ]
        destination_ports = [ "*" ]
        protocols = [ "Any" ]
        
      },
      
      {
        name = "spoke2-to-spoke1"
        source_addresses = [ "10.233.0.0/16" ]
        destination_addresses = [ "10.11.0.0/16" ]
        destination_ports = [ "*" ]
        protocols = [ "Any" ]
        
      }
       ]
    }]
 

    
  }
}

routingtable = {
  rt1 = {
    #  subnet_name = "subnet1"
    #  virtual_network_name = "spoke1"
     name = "Hub-RoutingTable"
      location = "West US"
      resource_group_name = "HS-anjali1"

      route = [
      #      {
      #   name = "default-to-internet"
      #   address_prefix = "0.0.0.0/0"
      #   next_hop_type = "Internet"
      # },
        {
        name = "to-spoke2"
        address_prefix = "10.233.0.0/16"
        next_hop_type = "VirtualAppliance"
        next_hop_in_ip_address = "10.0.26.4"
      },
      {
        name = "to-spoke1"
        address_prefix = "10.11.0.0/16"
        next_hop_type = "VirtualAppliance"
        next_hop_in_ip_address = "10.0.26.4"
      }
      ]

  }
}

vms = {
  spoke1_vm = {
    pip_name = "vm-pip"
    subnet_name  = "subnet1"
    vnet_name    = "spoke1"
    nic_name = "front-nic"
    ip_configuration = [
      { name                          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    ]

    vm_name             = "frontend-vm"
    resource_group_name = "HS-anjali1"
    location            = "West US"
    size                = "Standard_D2s_v3"
    admin_username      = "frontend"
    admin_password      = "Anjali@12345"

    os_disk = [
      {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    ]

    source_image_reference = [
      {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"

      }
    ]
  }

  spoke2_vm = {
    subnet_name  = "subnet2"
    vnet_name    = "spoke2"
    nic_name = "back-nic"
    ip_configuration = [
      { name                          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    ]

    vm_name             = "backend-vm"
    resource_group_name = "HS-anjali1"
    location            = "West US"
    size                = "Standard_D2s_v3"
    admin_username      = "backend"
    admin_password      = "Anjali@12345"

    os_disk = [
      {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    ]

    source_image_reference = [
      {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"

      }
    ]
  }
}

nsgs = {
  spoke1_nsg = {

    nsg_name             = "nsg1"
    resource_group_name  = "HS-anjali1"
    location             = "West US"
    subnet_name          = "subnet1"
    virtual_network_name = "spoke1"
    security_rule = [
      {
        name                       = "SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow inbound HTTP traffic"
      }
    ]
  }

  spoke2_nsg = {

    nsg_name             = "nsg2"
    resource_group_name  = "HS-anjali1"
    location             = "West US"
    subnet_name          = "subnet2"
    virtual_network_name = "spoke2"
    security_rule = [
      {
        name                       = "SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow inbound HTTP traffic"
      }
    ]
  }
}

