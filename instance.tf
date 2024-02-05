resource "aws_instance" "VPC-Instance" {
  ami             = var.ami
  key_name        = var.key
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.demo-public-subnet.id
  vpc_security_group_ids = [aws_security_group.vpc-sg.id]
  associate_public_ip_address = true
  }

resource "aws_security_group" "vpc-sg" {
  name        = "vpc-sg"
  vpc_id      = aws_vpc.demo-vpc.id
  tags = {
    Name = "vpc-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inrules" {
  security_group_id = aws_security_group.vpc-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "erules" {
  security_group_id = aws_security_group.vpc-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}