# module "db_instance" {
#   source  = "../modules/rds/db_instance"

#   identifier        = "my-aurora-cluster"

#   engine            = "aurora-mysql"
#   engine_version    = "5.7.mysql_aurora.2.12.2"
#   instance_class    = "db.t3.small"

#   snapshot_identifier = "test-snap"  # 복원할 스냅샷 ID


#   parameter_group_name = module.db_parameter_group

# }


resource "aws_instance" "example2" {
  ami           = "ami-029966e4fa23afc78"
  instance_type = "t2.micro" # 원하는 인스턴스 타입을 입력하세요.

  key_name      = "hk_an2_rsa"

  vpc_security_group_ids = ["sg-0485265aa6be0fa95"] # 보안 그룹 ID 추가

  lifecycle {
    ignore_changes = [
      ebs_block_device
    ]
  }

  root_block_device {
    volume_size           = 20 # 루트 볼륨 크기 (GiB 단위)
    volume_type           = "gp3" # 볼륨 타입 (gp2, io1, etc.)
    delete_on_termination = true # 인스턴스 종료 시 볼륨 삭제 여부
  }

  ebs_block_device {
    device_name           = "/dev/sdb" # 추가 EBS 볼륨의 디바이스 이름
    volume_size           = 50 # 추가 EBS 볼륨 크기 (GiB 단위)
    volume_type           = "gp3" # 볼륨 타입 (gp2, io1, etc.)
    delete_on_termination = true # 인스턴스 종료 시 볼륨 삭제 여부
  }


  tags = {
    Name = "ExampleInstance"
  }
}
