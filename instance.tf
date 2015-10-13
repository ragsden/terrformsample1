/* App servers */
resource "aws_instance" "app" {
  count = 2
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.ragterrapubsn.id}"
  security_groups = ["${aws_security_group.ragterrasg.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  user_data = "${file(\"cmd/app.yml\")}"
  tags = { 
    Name = "rag-terra-instance-${count.index}"
  }
}
