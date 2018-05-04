provider "aws" {
  version = "~> 1.16"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "${var.tag}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    Name = "${var.tag}"
  }
}

resource "aws_subnet" "priv_subnet" {
  vpc_id     = "${aws_vpc.main_vpc.id}"
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "${var.tag}"
  }
}

resource "aws_default_route_table" "rtable" {
  default_route_table_id = "${aws_vpc.main_vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.tag}"
  }
}

resource "aws_route_table_association" "rttblsbntassoc" {
  subnet_id      = "${aws_subnet.priv_subnet.id}"
  route_table_id = "${aws_default_route_table.rtable.id}"
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_vpc.main_vpc.default_network_acl_id}"
  subnet_ids             = ["${aws_subnet.priv_subnet.id}"]

  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "${var.tag}"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  ingress {
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.tag}"
  }
}
