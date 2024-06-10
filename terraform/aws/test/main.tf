
resource "aws_instance" "examplex" {
  ami                    = "ami-0d6e6a06d11d7777d" # 변경된 AMI ID
  instance_type          = "t3.nano" # 변경된 인스턴스 타입
  subnet_id              = "subnet-0e28cce7fef64bc65" # 기존 서브넷 ID
  key_name = "hk_an2_rsa"

  tags = {
    Name = "terraform-example3" # 변경된 태그
  }

  lifecycle {
    ignore_changes = [ ebs_block_device, user_data ]
  }

  root_block_device {
    delete_on_termination = false
    volume_size           = 11 # 변경된 볼륨 크기
    volume_type           = "gp3"
    encrypted             = true
    iops                  = 3000
    throughput            = 125
    kms_key_id            = "arn:aws:kms:ap-northeast-2:082284794827:key/edbcabc8-f231-43c6-b254-1ac5eedfe565"
  }

  vpc_security_group_ids = ["sg-0485265aa6be0fa95"] # 기존 보안 그룹 ID
}
