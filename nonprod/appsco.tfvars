environment = {
  dev-generic = {
    project_id                               = "apps-db-nonprod"
    criticality                              = "p4"
    cluster_name                             = "dev-db"
    db_version                               = "MYSQL_8_0"
    db_region                                = "us-central1"
    db_tier                                  = "db-custom-2-8192"
    zone                                     = "us-central1-a"
    random_instance_name                     = true
    deletion_protection                      = true
    deletion_protection_enabled              = true
    read_replica_deletion_protection         = false
    read_replica_deletion_protection_enabled = false
    availability_type                        = "REGIONAL"
    maintenance_window_day                   = 1
    maintenance_window_hour                  = 06
    maintenance_window_update_track          = "stable"
    database_flags = [{ name = "long_query_time", value = 1 },
    { name = "cloudsql_iam_authentication", value = "on" }]
    ip_configuration = {
      ipv4_enabled       = false
      require_ssl        = true
      network_project_id = "apps-shared-vpcs-host-nonprod"
      private_network    = "apps-shared-nonprod-vpc"
      subnetwork         = "apps-shared-uc1-nonprod-db"

      authorized_networks = [
        {
          name  = "Public Subnet"
          value = ""
        }
      ]
    }

    password_validation_policy_config = {
      enable_password_policy      = true
      complexity                  = "COMPLEXITY_DEFAULT"
      disallow_username_substring = true
      min_length                  = 8
    }

    backup_configuration = {
      enabled                        = true
      binary_log_enabled             = true
      start_time                     = "07:00"
      location                       = "us"
      transaction_log_retention_days = null
      retained_backups               = 7
      retention_unit                 = "COUNT"
    }

    read_replicas = []

    db_name      = "apps-db1"
    db_charset   = "utf8mb4"
    db_collation = "utf8mb4_general_ci"
    disk_size    = 10
    disk_type    = "PD_SSD"
    additional_databases = [
      {
        name      = "apps-db"
        charset   = "latin1"
        collation = "latin1_swedish_ci"
      }
    ]
  }
 }
