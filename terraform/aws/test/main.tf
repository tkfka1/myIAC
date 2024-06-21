resource "aws_db_instance" "from_snapshot" {
  identifier              = "restored-db-instance"
  snapshot_identifier     = "your-snapshot-id"  # 복원할 스냅샷 ID를 입력하세요.
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  db_subnet_group_name    = "your-db-subnet-group"  # 필요 시 서브넷 그룹 설정
  vpc_security_group_ids  = ["your-security-group-id"]  # 필요 시 보안 그룹 설정

  depends_on = [
    aws_db_subnet_group.db_subnet_group,  # 서브넷 그룹이 있는 경우 종속성 추가
  ]
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "your-db-subnet-group"
  subnet_ids = ["subnet-12345678", "subnet-87654321"]  # 서브넷 ID를 입력하세요.

  tags = {
    Name = "My DB subnet group"
  }
}
