data "google_compute_network" "network" {
  name    = local.ip_configuration.private_network
  project = local.ip_configuration.network_project_id
}

data "google_secret_manager_secret_version_access" "user_password" {
  project = var.secrets_project_id
  secret  = "cloudsql_nonprod_read_user"
}

data "google_secret_manager_secret_version_access" "root_password" {
  project = var.secrets_project_id
  secret  = "cloudsql_nonprod_root"
  version = "1"
}

module "mysql" {
  source                                   = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version                                  = "~> 20.2"
  name                                     = local.cluster_name
  random_instance_name                     = local.random_instance_name
  project_id                               = local.project_id
  database_version                         = local.db_version
  region                                   = local.region_name
  zone                                     = local.zone
  tier                                     = local.db_tier
  deletion_protection                      = local.deletion_protection
  deletion_protection_enabled              = local.deletion_protection_enabled
  read_replica_deletion_protection         = local.read_replica_deletion_protection
  read_replica_deletion_protection_enabled = local.read_replica_deletion_protection_enabled
  availability_type                        = local.availability_type
  maintenance_window_day                   = local.maintenance_window_day
  maintenance_window_hour                  = local.maintenance_window_hour
  maintenance_window_update_track          = local.maintenance_window_update_track
  database_flags                           = local.database_flags
  user_labels                              = local.labels
  ip_configuration                         = local.ip_configuration_dynamic
  password_validation_policy_config        = local.password_validation_policy_config
  backup_configuration                     = local.backup_configuration
  read_replica_name_suffix                 = join("", [local.cluster_name, "-"])
  replica_database_version                 = local.db_version
  read_replicas                            = local.read_replicas_dynamic



  db_name       = local.db_name
  db_charset    = local.db_charset
  db_collation  = local.db_collation
  user_name     = "root"
  user_password = data.google_secret_manager_secret_version_access.user_password.secret_data
  root_password = data.google_secret_manager_secret_version_access.root_password.secret_data
  #additional_users = local.additional_users
  additional_databases = local.additional_databases
  disk_size            = local.disk_size

}
