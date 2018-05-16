variable vpc_cidr {
  description = "This is the CIDR used to create the VPC"
  default     = "10.0.0.0/16"
}

variable tag {
  description = "This is used to tag all the resources managed by the module"
}
