resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    fiap = "hackathon"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet_public_1a.id

  tags = {
    fiap = "hackathon"
  }
}

resource "aws_route_table" "eks_nat_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    fiap = "hackathon"
  }
}
