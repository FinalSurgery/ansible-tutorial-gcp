provider "google" {
    credentials     = file(var.creds)
    project         = var.project
    region          = var.region
}
provider "google-beta" {
    credentials     = file(var.creds)
    project         = var.project
    region          = var.region
}
terraform {
    backend "local" { path = "/home/alexduvalcid/ansibler2/tr_test_files/terraform.tfstate" }
}