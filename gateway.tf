# Copyright (c) 2021 Oracle and/or its affiliates.

resource "oci_core_internet_gateway" "this" {
  provider       = oci
  compartment_id = var.compartment_ocid
  display_name   = "this"
  vcn_id         = oci_core_vcn.this.id

  enabled = true

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}