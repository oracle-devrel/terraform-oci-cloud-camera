# Copyright (c) 2021 Oracle and/or its affiliates.

resource "oci_core_instance" "cloud_camera" {
  availability_domain = local.ad_name
  compartment_id      = var.compartment_ocid
  display_name        = "cloud_camera"
  shape               = local.compute_shape
  shape_config {
    memory_in_gbs = 8
    ocpus         = 1
  }
  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }
  create_vnic_details {
    assign_private_dns_record = true
    assign_public_ip          = true
    display_name              = "cloud_camera"
    hostname_label            = "cloudcamera"
    nsg_ids = [
      oci_core_network_security_group.cloud_camera.id
    ]
    skip_source_dest_check = false
    subnet_id              = oci_core_subnet.this.id
  }
  metadata = {
    ssh_authorized_keys = local.ssh_public_keys
    user_data = base64encode(templatefile("${path.root}/cloud-camera.tpl", {
      opc_passwd = var.opc_passwd,
      vnc_passwd = var.vnc_passwd
    }))
  }
  source_details {
    source_id   = local.compute_image_id
    source_type = "image"

    boot_volume_size_in_gbs = 50
  }
  preserve_boot_volume = false

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}
