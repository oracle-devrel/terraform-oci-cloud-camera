# Copyright (c) 2021 Oracle and/or its affiliates.

resource "oci_core_subnet" "this" {
  provider       = oci
  compartment_id = var.compartment_ocid

  display_name = "cloud_camera"
  dns_label    = "cloudcamera"
  cidr_block   = "192.168.0.0/28"
  vcn_id       = oci_core_vcn.this.id

  # ipv6cidr_block = var.subnet_ipv6cidr_block
  prohibit_internet_ingress  = false
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.public.id

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}
