terraform {
  required_version = "~> 1.10"
  backend "gcs" {
    bucket = "tf-apps-projects-nonprod"
    prefix = "tf-apps-db/tfstate"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.9"
    }

  }
}

provider "google" {
  region = var.region_name
}
