resource "google_compute_address" "lamperns" {
    name = "lamperns"
    region = var.region
    address_type = "EXTERNAL"
}