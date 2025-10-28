resource "aws_instance" "Machine-2" {
  ami           = "ami-075449515af5df0d1"
  instance_type = "t3.micro"
  key_name      = "keyInTerminal"
  tags = {
    Name = "SonreQube and Nexux Machine"
  }
}
