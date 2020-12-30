resource "google_compute_address" "static" {
    name = "hoster"
    region = var.region
    address_type = "EXTERNAL"
}