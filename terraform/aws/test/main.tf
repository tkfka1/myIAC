resource "aws_instance" "example3" {
  ami           = "ami-0b8414ae0d8d8b4cc"
  instance_type = "t3.nano"
  key_name = "hk_an2_rsa"
  
  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
  }
  
  tags = {
    Name = "terraform-example3"
  }
}
	
resource "aws_instance" "example4" {
  ami           = "ami-0ff0fc8eddd393732"
  instance_type = "t3.nano"
  key_name = "hk_an2_rsa"
  
  root_block_device {
    encrypted = true
  }
  
  tags = {
    Name = "terraform-example-end"
  }
}

resource "aws_instance" "example4_old" {
  ami           = "ami-01890a6b9be8ab599"
  instance_type = "t3.nano"
  key_name = "hk_an2_rsa"
  
  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    encrypted = true
  }
  
  tags = {
    Name = "terraform-example-end"
  }
}