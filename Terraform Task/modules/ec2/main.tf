resource "aws_instance" "app" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  count         = var.instance_count
  subnet_id     = var.subnet_id
}
