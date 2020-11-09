provider "aws" {
  profile = "default"
  region = var.region
}

resource "aws_instance" "jumpapi"{
  ami                    = "ami-07dd19a7900a1f049"
  instance_type          = "t2.medium"
  key_name               = var.key_name

  tags = {
    Name = "jumpapi"
  }
}
