resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 LTS AMI
  instance_type = "t2.micro"
  
  tags = {
    Name = "terraform-example"
  }
}