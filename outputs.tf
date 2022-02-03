# Copyright (c) 2021 Oracle and/or its affiliates.

output "pub_ip" {
  value = oci_core_instance.cloud_camera.public_ip
}

output "ssh_cmd" {
  value = "ssh opc@${oci_core_instance.cloud_camera.public_ip}"
}

output "ssh_with_vnc_cmd" {
  value = "ssh -L 5901:localhost:5901 opc@${oci_core_instance.cloud_camera.public_ip}"
}

