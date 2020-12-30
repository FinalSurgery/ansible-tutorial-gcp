resource "google_compute_attached_disk" "brain" {
    disk            = google_compute_disk.diskerino.self_link
    instance        = google_compute_instance.brain.self_link
}

resource "google_compute_instance" "brain" {
    name            = "lamperino"
    machine_type    = var.machine
    zone            = var.zone

    boot_disk {
        initialize_params{
            image       = var.OS
        }
    }
    network_interface {
        network         = var.network
        access_config {
            nat_ip      = google_compute_address.lamperns.address
        }
    }
}




