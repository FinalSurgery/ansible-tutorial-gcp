resource "google_compute_disk" "diskerino" {
  name  = "lampdb"
  type  = "pd-ssd"
  zone  = var.zone
  size  = 100
  physical_block_size_bytes = 4096
}