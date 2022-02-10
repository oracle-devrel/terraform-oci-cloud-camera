# Copyright (c) 2021 Oracle and/or its affiliates.

variable "tenancy_ocid" {
  description = "OCI tenant OCID, more details can be found at https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#five"
}
variable "region" {
  description = "OCI Region as documented at https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm"
  default     = "us-phoenix-1"
}
variable "compartment_ocid" {
  default     = ""
  description = "The compartment OCID to deploy resources to"
}
variable "user_ocid" {
  default     = ""
  description = "OCI user OCID, more details can be found at https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#five"
}
variable "fingerprint" {
  default     = ""
  description = "'API Key' fingerprint, more details can be found at https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/credentials.htm#two"
}
variable "private_key" {
  default     = ""
  description = "The private key (provided as a string value)"
}
variable "private_key_path" {
  default     = ""
  description = "Path to private key used to create OCI 'API Key', more details can be found at https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/credentials.htm#two"
}
variable "private_key_password" {
  default     = ""
  description = "The password to use for the private key"
}
# see https://docs.oracle.com/en-us/iaas/images/ for image names
variable "compute_image_name" {
  type        = string
  default     = ""
  description = "The name of the compute image to use for the compute instances."
}
variable "ssh_pub_key_path" {
  type        = string
  default     = ""
  description = "The path to the SSH public key to use for the compute instances."
}
variable "ssh_pub_key" {
  type        = string
  default     = ""
  description = "The SSH public key contents to use for the compute instances."
}

variable "compute_shape" {
  type        = string
  description = "See https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm for the different compute shapes available."
  default     = "VM.Standard.A1.Flex"
}
variable "ad_number" {
  type        = number
  description = "The AD number to deploy the Compute instance in.  1 = AD1, 2 = AD2, 3 = AD3."
}

variable "permitted_access_cidrs" {
  type        = list(string)
  description = "The CIDR block(s) permitted to access the server"
}

variable "udp_service_port" {
  type        = number
  description = "The UDP port to use for streaming"
  default     = 8100
}

variable "opc_passwd" {
  type        = string
  description = "The password to use for the opc OL8 account."
  sensitive   = true
}

variable "vnc_passwd" {
  type        = string
  description = "The password to use for connecting to the VNC session."
  sensitive   = true
}
