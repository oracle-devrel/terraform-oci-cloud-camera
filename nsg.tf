# Copyright (c) 2021 Oracle and/or its affiliates.

resource "oci_core_network_security_group" "cloud_camera" {
  provider       = oci
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "cloud_camera"

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

resource "oci_core_network_security_group_security_rule" "outbound_https" {
  provider                  = oci
  network_security_group_id = oci_core_network_security_group.cloud_camera.id
  direction                 = "EGRESS"
  protocol                  = "6"
  stateless                 = false
  tcp_options {
    destination_port_range {
      max = "443"
      min = "443"
    }
  }
  description      = "Permit HTTPS (tcp/443) to the web"
  destination      = "0.0.0.0/0"
  destination_type = local.nsg_types["cidr"]
}

resource "oci_core_network_security_group_security_rule" "inbound_udp_feed" {
  for_each                  = toset(var.permitted_access_cidrs)
  provider                  = oci
  network_security_group_id = oci_core_network_security_group.cloud_camera.id
  direction                 = "INGRESS"
  protocol                  = "17"
  stateless                 = false
  udp_options {
    destination_port_range {
      max = var.udp_service_port
      min = var.udp_service_port
    }
  }
  description = "Permit UDP stream from my IP"
  source      = each.key
  source_type = local.nsg_types["cidr"]
}

resource "oci_core_network_security_group_security_rule" "inbound_icmp" {
  for_each                  = toset(var.permitted_access_cidrs)
  provider                  = oci
  network_security_group_id = oci_core_network_security_group.cloud_camera.id
  direction                 = "INGRESS"
  protocol                  = "1"
  stateless                 = false
  description               = "Permit ICMP from allowed IP"
  source                    = each.key
  source_type               = local.nsg_types["cidr"]
}

resource "oci_core_network_security_group_security_rule" "inbound_udp_all" {
  for_each                  = toset(var.permitted_access_cidrs)
  provider                  = oci
  network_security_group_id = oci_core_network_security_group.cloud_camera.id
  direction                 = "INGRESS"
  protocol                  = "17"
  stateless                 = false
  description               = "Permit all UDP from allowed public IP(s)"
  source                    = each.key
  source_type               = local.nsg_types["cidr"]
}
