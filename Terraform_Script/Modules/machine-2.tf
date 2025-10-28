resource "aws_instance" "Machine-2" {
  ami           = "ami-0a716d3f3b16d290c"
  instance_type = "t3.micro"
  key_name      = "keyInTerminal"
  tags = {
    Name = "SonreQube and Nexux Machine"
  }
}
