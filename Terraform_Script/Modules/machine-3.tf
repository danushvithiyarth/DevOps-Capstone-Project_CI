resource "aws_instance" "Machine-3" {
  ami           = "ami-0a716d3f3b16d290c"
  instance_type = "t3.large"
  key_name      = "keyInTerminal"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.Machine-3-securitygroup.id]
  associate_public_ip_address = true
  root_block_device {
    volume_size = 35
    volume_type = "gp3"
  }
  tags = {
    Name = "Deployment Machine-3"
  }
}

resource "aws_security_group" "Machine-3-securitygroup" {
  name        = "Machine-3-securitygroup"
  description = "SG for Machine-3"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "9090"
    to_port     = "9090"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "3000"
    to_port     = "3000"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

