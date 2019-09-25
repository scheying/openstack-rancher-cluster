resource "openstack_images_image_v2" "rancheros" {
  name             = "RancherOS"
  image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
  container_format = "bare"
  disk_format      = "qcow2"
}

/*

resource "ovh_publiccloud_private_network" "gh-net" {
   project_id = "67890"
   name       = "admin_network"
   regions    = ["GRA1", "BHS1"]
}

*/

resource "openstack_compute_instance_v2" "rancher-master" {
  name            = "rancher-master"
  image_id        = openstack_images_image_v2.rancheros.id
  flavor_id       = "92416632-fece-42f0-a6a4-70b2d416fa1d"
  security_groups = ["default"]
  user_data       = file("user-data-master.yml")
  config_drive    = true

  network {
    uuid = "bf8869ea-aaba-4a34-b7e9-9010861ff5f6"
  }
}

resource "openstack_compute_instance_v2" "rancher-node" {
  name            = "rancher-node-${count.index}"
  image_id        = openstack_images_image_v2.rancheros.id
  count           = 3
  flavor_id       = "92416632-fece-42f0-a6a4-70b2d416fa1d"
  security_groups = ["default"]
  user_data       = file("user-data-node.yml")
  config_drive    = true

  network {
    uuid = "bf8869ea-aaba-4a34-b7e9-9010861ff5f6"
  }
}

output "rancher-url" {
  value = "http://${openstack_compute_instance_v2.rancher-master.access_ip_v4}:8080"
}
