variable "vsphere_user" {
  description = "The vSphere user to be used"
}

variable "vsphere_password" {
  description = "The vSphere user's password"
}

variable "vsphere_server" {
  description = "The vSphere server to use"
  default     = "172.17.103.250"
}

variable "cpu_number" {
  description = "Number of CPU cores for the VM."
  default     = 1
}

variable "ram_size" {
  description = "VM RAM size in megabytes."
  default     = 1024
}

variable "datacenter" {
  description = "The datacenter to deploy the VM."
}

variable "datastore" {
  description = "The datastore to store the VM."
}

variable "cluster" {
  description = "The cluster to deploy the VM."
  default     = "ClusterTest"
}

variable "network_name" {
  description = "The network name to attach the VM."
}

#variable "host" {
#  description = "the host"
#  default     = "self.default_ip_address"
#}

#variable "iso" {
#  description = "iso"
#  default     = "0_ISO/debian-12.5.0-amd64-netinst.iso"
#}

#variable "ssh_private_key" {
#  description = "Chemin de la clé privée SSH"
#  type        = string
#}

#variable "ansible_user" {
#  description = "Utilisateur SSH pour Ansible"
#  type        = string
#  default     = "root"
#}
