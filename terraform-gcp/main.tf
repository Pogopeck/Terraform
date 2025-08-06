provider "google" {
  project = var.project_id
  region  = "us-central1"
}

resource "google_compute_instance" "vm" {
  name         = "terraform-codespace-vm"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "echo 'Hello from GCP!' > /home/debian/message.txt"

  labels = {
    created-by = "terraform"
  }
}

output "external_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
