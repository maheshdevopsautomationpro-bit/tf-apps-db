# tf-apps-db
Template repository for apps projects using terraform to manage GCP and related resources.

## Overview

This repository uses Terraform to manage Google Cloud Platform (GCP) resources, specifically Cloud SQL instances (MySQL) for application databases. It is designed to provide a standardized and automated way to provision and manage database infrastructure for various environments.

## Configuration

The `nonprod` directory contains the Terraform configuration for non-production environments. Key configuration files include:

- `main.tf`: Defines the core resources, including the Google Cloud SQL MySQL instance, network configuration, and secret manager access for database credentials.
- `vars.tf`: Declares input variables for the Terraform configuration, such as `environment`, `region_name`, and `secrets_project_id`.
- `locals.tf`: Defines local variables that derive values from input variables and data sources, providing a more organized and DRY (Don't Repeat Yourself) configuration.
- `appsco.tfvars`: Contains environment-specific variable values for the non-production environment.
- `backend.tf`: Configures the Terraform backend for state management.

## Features

- **Cloud SQL for MySQL**: Provisions and manages MySQL instances on GCP.
- **Secret Management**: Integrates with Google Secret Manager for secure storage and retrieval of database user and root passwords.
- **Network Configuration**: Configures private IP for database instances within a specified VPC network.
- **Read Replicas**: Supports the creation and management of read replicas for high availability and read scaling.
- **Automated Backups**: Configures automated backups for database instances.
- **Password Validation Policy**: Enforces password policies for database users.
- **Deletion Protection**: Enables deletion protection for critical database instances.

## Setup

To get started with this repository, ensure you have the following prerequisites:

- **Terraform**: Install Terraform (v1.0.0 or higher).
- **GCP Project**: A Google Cloud Project with the necessary APIs enabled (e.g., Cloud SQL Admin API, Secret Manager API, Compute Engine API).
- **GCP Credentials**: Authenticate Terraform with your GCP account.

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-org/tf-apps-db.git
   cd tf-apps-db
   ```

2. **Initialize Terraform:**

   Navigate to the environment-specific directory (e.g., `nonprod`) and initialize Terraform:

   ```bash
   cd nonprod
   terraform init
   ```

3. **Review and Plan:**

   Review the planned infrastructure changes before applying:

   ```bash
   terraform plan -var-file="appsco.tfvars"
   ```

4. **Apply Changes:**

   Apply the Terraform configuration to provision the resources:

   ```bash
   terraform apply -var-file="appsco.tfvars"
   ```

## Usage

After applying the Terraform configuration, your Cloud SQL instances will be provisioned and accessible. You can connect to your databases using the provisioned users and passwords retrieved from Google Secret Manager.

## License

This project is licensed under the MIT License.