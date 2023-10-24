terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
        source = "telmate/proxmox"
    }
  }
}

# Using proxmox from a vagrant e.g. https://github.com/rgl/proxmox-ve
provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://proxmox-server01.example.com:8006/api2/json"
    pm_password = "secret"
    pm_user = "terraform-prov@pve"
    pm_otp = ""
}

resource "proxmox_vm_qemu" "example" {
    name = "servy-mcserverface"
    desc = "A test for using terraform and vagrant"
    target_node = "pve"
}