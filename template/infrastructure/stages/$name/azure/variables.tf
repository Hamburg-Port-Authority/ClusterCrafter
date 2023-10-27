variable "name" {
  type = string
}


variable "tags" {
  type = map(string)
  default = {
    TF-Managed  = "true"
    Maintainer  = "HPA"
    TF-Worfklow = ""
    Owner       = "HSA"
    PoC         = "AKS"
  }
}


########## Azure AD User ##########
variable "azuread_user_name" {

  type        = string
  description = "value of the user name"

}

variable "azuread_user_display_name" {

  type        = string
  description = "value of the display name"
}

variable "azuread_user_mail_nickname" {

  type        = string
  description = "value of the mail nickname"

}


########## Azure AD Group ##########
variable "azuread_group_display_name" {
  type        = string
  default     = ""
  description = "display_name - (Required) The display name for the group."
}
variable "owners" {
  type        = list(string)
  default     = []
  description = <<-EOT
    (Optional) A set of object IDs of principals that will be granted ownership of the group.
    Supported object types are users or service principals.
    By default, the principal being used to execute Terraform is assigned as the sole owner.
    Groups cannot be created with no owners or have all their owners removed.
  EOT
}
variable "members" {
  type        = list(string)
  default     = []
  description = <<-EOT
     (Optional) A set of members who should be present in this group.
     Supported object types are Users, Groups or Service Principals.
     Cannot be used with the dynamic_membership block.
  EOT
}

########## Azure Container Registries ##########

variable "sku" {

  type        = string
  default     = "Premium"
  description = "(Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium."
}

variable "admin_enabled" {

  type        = bool
  default     = false
  description = " (Optional) Specifies whether the admin user is enabled. Defaults to false."
}


variable "acr_name" {

  type        = string
  description = "(Required) Specifies the name of the container registry. Changing this forces a new resource to be created."
}


########## Azure Key Vault ##########

variable "network_acls" {

  type = object({
    bypass                     = string,
    default_action             = string,
    ip_rules                   = list(string),
    virtual_network_subnet_ids = list(string),
  })

  default = {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  description = "(Optional) A network_acls block as defined below"

}

variable "key_vault_admin_object_ids" {
  type        = list(string)
  description = "Optional list of object IDs of users or groups who should be Key Vault Administrators. Should only be set, if enable_rbac_authorization is set to true."
  default     = []
}

variable "role_definition_name" {
  type        = string
  description = "The Scoped-ID of the Role Definition. Changing this forces a new resource to be created. Conflicts with role_definition_name"
  default     = "Key Vault Administrator"
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  default     = true
}

variable "key_vault_name" {
  type        = string
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created."
}

########## Azure AD Grafana Enterprise App + App Registration ##########
variable "grafana_aad_app" {
  type = map(object({
    display_name                 = string
    redirect_uris                = list(string)
    logout_url                   = string
    app_role_assignment_required = bool
    app_owners                   = list(string)
    roles = map(object({
      app_role_id         = string
      principal_object_id = string
    }))

  }))

  default = {}
}


variable "grafana_app_roles" {
  type = map(object({
    allowed_member_types = list(string)
    description          = string
    display_name         = string
    enabled              = bool
    id                   = string
    value                = string


  }))
  default = {

    "grafana_viewer" = {
      allowed_member_types = ["User"]
      description          = "Grafana read only Users"
      display_name         = "Grafana Viewer"
      enabled              = true
      id                   = "5ece0e92-30f6-4c31-8c94-e7195c20f668"
      value                = "Viewer"
    },

    "grafana_editor" = {
      allowed_member_types = ["User"]
      description          = "Grafana Editor Users"
      display_name         = "Grafana Editor"
      enabled              = true
      id                   = "2b2d3ad4-1c78-45db-a077-909f755c36aa"
      value                = "Editor"
    },

    "grafana_admin" = {
      allowed_member_types = ["User"]
      description          = "Grafana admin Users"
      display_name         = "Grafana Admin"
      enabled              = true
      id                   = "e15be93c-edc1-4b89-ad19-c5f143de6ebd"
      value                = "Admin"
    }

  }

  description = <<-EOT
    List of app_roles to configure app_role in for a aad application.

    Example:

    default = {

      "grafana_viewer" = {
        allowed_member_types = ["User"]
        description          = "Grafana read only Users"
        display_name         = "Grafana Viewer"
        enabled              = true
        id                   = "5ece0e92-30f6-4c31-8c94-e7195c20f668"
        value                = "Viewer"
      },

      "grafana_editor" = {
        allowed_member_types = ["User"]
        description          = "Grafana Editor Users"
        display_name         = "Grafana Editor"
        enabled              = true
        id                   = "2b2d3ad4-1c78-45db-a077-909f755c36aa"
        value                = "Editor"
      }

    }

   Explanation:
   A collection of app_role blocks as documented below. For more information see official documentation on Application Roles.

  EOT
}



variable "external_secrets_aad_app" {
  type = map(object({
    display_name                 = string
    redirect_uris                = list(string)
    logout_url                   = string
    app_role_assignment_required = bool
    app_owners                   = list(string)
    roles = map(object({
      app_role_id         = string
      principal_object_id = string
    }))

  }))

  default = {}
}
