//creating vpc
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
}

//creating igw  
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}

//creating public subnet
resource "aws_subnet" "demo-public-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "demo-public-subnet"
  }
}

//creating private subnet
resource "aws_subnet" "demo-private-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "demo-private-subnet"
  }
}

//creating route table
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }

  tags = {
    Name = "demo-rt"
  }
}

//creating subnet association for public subnet
resource "aws_route_table_association" "demo-sub-as-public" {
  subnet_id      = aws_subnet.demo-public-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}

