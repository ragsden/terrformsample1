/* Default security group */
resource "aws_security_group" "ragterrasg" {
  name = "raghu-terraform-sg"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id = "${aws_vpc.default.id}"
  
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  tags { 
    Name = "raghu-terraform-sg" 
  }
}


/* Security group for the web */
resource "aws_security_group" "web" {
  name = "raghu-terraform-web-sg"
  description = "Security group for web that allows web traffic from internet"
  vpc_id = "${aws_vpc.default.id}"
  
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags { 
    Name = "raghu-terraform-web-sg" 
  }
}
