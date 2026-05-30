# -----------------------------------------------
# DATA SOURCE
# -----------------------------------------------
data "azuread_client_config" "current" {}

# -----------------------------------------------
# USERS — Terraform managed
# -----------------------------------------------
resource "azuread_user" "svc_graphapi" {
  user_principal_name   = "svc.graphapi@ByteKage.onmicrosoft.com"
  display_name          = "Graph API Service Account"
  mail_nickname         = "svc.graphapi"
  password              = "TempPassword123!"
  force_password_change = true
}

# -----------------------------------------------
# GROUPS — Terraform managed
# -----------------------------------------------
resource "azuread_group" "service_accounts" {
  display_name     = "ByteKage-ServiceAccounts"
  security_enabled = true
  description      = "Service and automation accounts"
}

resource "azuread_group" "guest_users" {
  display_name     = "ByteKage-GuestUsers"
  security_enabled = true
  description      = "External guest identities"
}

# -----------------------------------------------
# GROUP MEMBERSHIP — Terraform managed
# -----------------------------------------------
resource "azuread_group_member" "svc_graphapi_to_serviceaccounts" {
  group_object_id  = azuread_group.service_accounts.id
  member_object_id = azuread_user.svc_graphapi.id
}