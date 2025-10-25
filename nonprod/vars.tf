############################################
##
##  W O R K S P A C E    V A R I A B L E
##  Required for enabling the workspace<->varible mappings.
##
############################################

variable "environment" {
  type = map(any)
}

variable "region_name" {
  type    = string
  default = "us-central1"
}

variable "secrets_project_id" {
  type    = string
  default = "apps-secrets-mgmt"
}
