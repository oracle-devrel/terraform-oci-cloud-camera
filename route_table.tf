# Copyright (c) 2021 Oracle and/or its affiliates.

resource "oci_core_route_table" "public" {
  provider       = oci
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "public"

  route_rules {
    network_entity_id = oci_core_internet_gateway.this.id
    description       = "Default route"
    destination       = "0.0.0.0/0"
    destination_type  = local.dest_types["cidr"]
  }

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}
