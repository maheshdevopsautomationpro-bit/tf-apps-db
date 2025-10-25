locals {
  # Terraform Workspace Environment Variable
  ws_environment                           = var.environment[terraform.workspace]
  environment                              = terraform.workspace
  application                              = "apps-db-cloudsql"
  stack                                    = "apps-db-cloudsql"
  project_id                               = local.ws_environment["project_id"]
  region_name                              = local.ws_environment["db_region"]
  db_tier                                  = local.ws_environment["db_tier"]
  cluster_name                             = local.ws_environment["cluster_name"]
  random_instance_name                     = local.ws_environment["random_instance_name"]
  deletion_protection                      = local.ws_environment["deletion_protection"]
  deletion_protection_enabled              = local.ws_environment["deletion_protection_enabled"]
  read_replica_deletion_protection         = local.ws_environment["read_replica_deletion_protection"]
  read_replica_deletion_protection_enabled = local.ws_environment["read_replica_deletion_protection_enabled"]
  availability_type                        = local.ws_environment["availability_type"]
  maintenance_window_day                   = local.ws_environment["maintenance_window_day"]
  maintenance_window_hour                  = local.ws_environment["maintenance_window_hour"]
  maintenance_window_update_track          = local.ws_environment["maintenance_window_update_track"]
  database_flags                           = local.ws_environment["database_flags"]
  ip_configuration                         = local.ws_environment["ip_configuration"]
  password_validation_policy_config        = local.ws_environment["password_validation_policy_config"]
  backup_configuration                     = local.ws_environment["backup_configuration"]
  read_replicas                            = local.ws_environment["read_replicas"]
  db_name                                  = local.ws_environment["db_name"]
  disk_size                                = local.ws_environment["disk_size"]
  db_charset                               = local.ws_environment["db_charset"]
  db_collation                             = local.ws_environment["db_collation"]
  additional_databases                     = local.ws_environment["additional_databases"]
  db_version                               = local.ws_environment["db_version"]
  criticality                              = local.ws_environment["criticality"]
  zone                                     = local.ws_environment["zone"]

  ip_configuration_dynamic = {
    ipv4_enabled        = local.ip_configuration.ipv4_enabled
    require_ssl         = local.ip_configuration.require_ssl
    private_network     = data.google_compute_network.network.id
    allocated_ip_range  = local.ip_configuration.subnetwork
    authorized_networks = local.ip_configuration.authorized_networks
  }

  read_replicas_dynamic = [for i in local.read_replicas :
    {
      name                  = i.name
      zone                  = i.zone
      availability_type     = i.availability_type
      tier                  = i.tier
      disk_autoresize       = i.disk_autoresize
      disk_autoresize_limit = i.disk_autoresize_limit
      disk_size             = i.disk_size
      user_labels           = local.labels
      encryption_key_name   = i.encryption_key_name
      database_flags        = i.database_flags
      ip_configuration      = local.ip_configuration_dynamic
    }

  ]

  labels = {
    application      = local.application
    environment      = local.environment
    stack            = local.stack
    business_owner   = "apps"
    operations_owner = "appsdevops"
    app_owner        = "appsops"

    # none     - no encryption is needed for this application
    # optional - encryption is optional on resources that may hold PII or to meet compliance
    # required - resources are encrypted according to compliance guidelines, may include data at rest
    encryption = "none"

 
  }



}

output "name" {
  value = local.read_replicas_dynamic
}
