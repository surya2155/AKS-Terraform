location  = "eastus2"
virtual_network_name = "vnet-test"
vnet_address_space   = ["10.0.0.0/16"]
resource_group_name = "test-rg2"

keyvault_name = "testsurya-vault-01"
enabled_for_disk_encryption = "false"
purge_protection_enabled    = "false"

aks_name = "test-cluster"

dns_prefix = "testcluster"

nodecount   = "1"

nodesize    = "Standard_D2_v2"

