# Configuration du provider vSphere
provider "vsphere" {
  vsphere_server        = var.vsphere_server
  user                  = var.vsphere_user
  password              = var.vsphere_password
  allow_unverified_ssl  = true
}

# Récupération du datacenter
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

# Récupération du cluster
data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Récupération du datastore
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Récupération du réseau
data "vsphere_network" "network" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datacenter" "datacenter" {
  name = "Datacenter"
}


# ressource pool
data "vsphere_resource_pool" "pool" {
  name          = "PROJETS"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# Création de la machine virtuelle
resource "vsphere_virtual_machine" "vm" {
  name             = "examplevm2"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.cpu_number
  memory   = var.ram_size
  guest_id = "debian12_64Guest"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 20
    eagerly_scrub    = false
    thin_provisioned = true
  }

#  data "vsphere_virtual_machine" "debian" {
#    name          = "/${var.datacenter}/0_ISO/${var.iso}"
#    datacenter_id = data.vsphere_datacenter.datacenter.id
#  }

  clone {
    template_uuid = "4234899e-3eca-a702-d3c4-d07064b2a385" 
  }

# Ajouter un provisioner pour installer Ansible
#  provisioner "remote-exec" {
#    connection {
#      type        = "ssh"
#      user        = "root"
#      password    = "password"
#      host        = self.default_ip_address
#      port        = 22
#    }
#  }
# Provisionnement avec Ansible via local-exec


  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      password    = "root"
      host        = var.host
      port        = 22
    }
    inline = [
      "echo 'test'",
#      "ansible-playbook playbook.yml"
    ]
  }

  provisioner "local-exec" {
    command = "ansible-playbook playbook.yml"
  }  
}


