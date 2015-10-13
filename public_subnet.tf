/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ragterraig" {
  vpc_id = "${aws_vpc.default.id}"
  tags { 
    Name = "ragterraig" 
  }
}

/* Public subnet */
resource "aws_subnet" "ragterrapubsn" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "${var.availability_zone}"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.ragterraig"]
  tags { 
    Name = "ragterrapubsn" 
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "ragterrart" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ragterraig.id}"
  }
  tags { 
    Name = "ragterrart" 
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.ragterrapubsn.id}"
  route_table_id = "${aws_route_table.ragterrart.id}"
}
