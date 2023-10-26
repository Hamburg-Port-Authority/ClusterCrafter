
resource "azuread_group" "main" {
  display_name     = var.azuread_group_display_name
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true

  members = data.azuread_users.members.object_ids
}
