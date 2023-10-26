
module "resource_group_infra" {
  source = "github.com/Hamburg-Port-Authority/terraform-azure-resource-group?ref=1.0.0"

  name     = format("rg-%s-%s", var.name, "infrastructure")
  location = var.location
  tags     = var.tags

}


module "key_vault" {
  source = "github.com/Hamburg-Port-Authority/terraform-azure-key-vault?ref=1.0.0"

  name                       = var.key_vault_name
  resource_group_name        = module.resource_group_infra.name
  network_acls               = var.network_acls
  enable_rbac_authorization  = var.enable_rbac_authorization
  key_vault_admin_object_ids = [data.azuread_group.it_adm.object_id]

  depends_on = [
    module.resource_group_infra
  ]

}



module "acr" {
  source = "github.com/Hamburg-Port-Authority/terraform-azure-acr?ref=1.0.1"

  name                = var.acr_name
  resource_group_name = module.resource_group_infra.name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  tags = var.tags

  depends_on = [
    module.resource_group_infra
  ]

}
