module "vpc" {
  source  = "smrutimandal/vpc/aws"
  version = "0.0.3"
  tag     = "${var.tag}"
}
