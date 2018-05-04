module "vpc" {
  source  = "smrutimandal/vpc/aws"
  version = "0.0.2"
  tag     = "${var.tag}"
}
