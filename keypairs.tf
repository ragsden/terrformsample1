resource "aws_key_pair" "deployer" {
  key_name   = "rag-terra-key" 
  public_key = "${file(\"ssh/rag-terra-deploy.pub\")}"
}
