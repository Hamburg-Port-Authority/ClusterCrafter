
resource "random_password" "password" {
  length = 24
}

resource "azuread_user" "svc_user" {
  user_principal_name = var.azuread_user_name
  display_name        = var.azuread_user_display_name
  mail_nickname       = var.azuread_user_mail_nickname
  password            = random_password.password.result
}
