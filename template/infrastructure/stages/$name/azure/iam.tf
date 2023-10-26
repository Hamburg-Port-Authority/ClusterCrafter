resource "azurerm_role_assignment" "key_vault_officer_sp" {

  scope                = module.key_vault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azuread_service_principal.devops_terraform_cicd.object_id
}




resource "azurerm_role_assignment" "key_vault_admin" {

  scope                = module.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azuread_group.main.object_id
}


resource "azurerm_role_assignment" "resource_group_infra_contributor" {

  scope                = module.resource_group_infra.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.main.object_id

}
