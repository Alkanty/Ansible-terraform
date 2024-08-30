terraform {
  required_providers {
    vsphere={
      source="hashicorp/vsphere"
      version=">=2.8.0"
    }
    ansible = {
      version=">=1.3.0"
      source  = "ansible/ansible"
    }
  }
  required_version=">=0.13"
}
