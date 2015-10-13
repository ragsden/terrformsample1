/* Load balancer */
resource "aws_elb" "ragterraelb" {
  name = "rag-terra-elb"
  subnets = ["${aws_subnet.ragterrapubsn.id}"]
  security_groups = ["${aws_security_group.ragterrasg.id}", "${aws_security_group.web.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
    instances = ["${aws_instance.app.*.id}"]
}
