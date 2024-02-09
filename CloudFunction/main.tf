provider "google" {
  project     = var.project
  region      = var.region
  zone        = "us-central1-c"
  credentials = "C:\\Users\\HP\\Documents\\coding-challenge\\rosy-sunspot-413715-436b839aa9a1.json"
}

module "cloud_functions" {
  source = "./modules/cloud_functions"
}
