resource "google_compute_instance" "host" {

    name            = "hosterino"
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
            nat_ip      = google_compute_address.static.address

        }
    }
}