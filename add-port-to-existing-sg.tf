provider "aws" {
  region = "us-east-1"
}

data "aws_security_group" "previous-sg" {
  id = "sg-015ba5274b3928db2" # existing security group id
}

resource "aws_instance" "Instance" {
  ami                    = "ami-000ec6c25978d5999"
  instance_type          = "t2.micro"
  key_name               = "lti-dev()" # Make sure this key name exists in your AWS account
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [data.aws_security_group.previous-sg.id]

  tags = {
    Name = "jas-ec2-server"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = data.aws_security_group.previous-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = data.aws_security_group.previous-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
