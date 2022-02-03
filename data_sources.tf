# Copyright (c) 2021 Oracle and/or its affiliates.

data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

data "oci_core_images" "this" {
  compartment_id = var.compartment_ocid
  filter {
    name   = "state"
    values = ["AVAILABLE"]
  }
}

data "oci_identity_availability_domains" "ads" {
  provider       = oci
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "latest_ol8" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = 8.0
  shape                    = local.compute_shape
  state                    = "AVAILABLE"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

data "oci_core_images" "specified" {
  compartment_id = var.tenancy_ocid
  display_name   = var.compute_image_name
  shape          = local.compute_shape
  state          = "AVAILABLE"
}