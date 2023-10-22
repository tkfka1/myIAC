# 모든 AZs 검색
# 사용 가능한 모든 가용성 영역(Availability Zones)을 검색한다.
data "aws_availability_zones" "available" {
  state = "available" # 사용 가능한 상태의 AZ만 검색
}

# 최신 Ubuntu 22.04 AMI ID 검색
# AWS에서 가장 최근에 발표된 Ubuntu 22.04 AMI ID를 검색한다.
data "aws_ami" "ubuntu" {
  most_recent = true # 최신 버전의 AMI만 검색

  # AMI의 이름 필터링: Ubuntu 22.04 AMI를 찾기 위한 이름 패턴
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*22.04*-amd64-server-*"]
  }

  # 가상화 타입 필터링: HVM 가상화를 사용하는 AMI만 검색
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical(우분투 제작사)의 AWS 계정 ID로 소유한 AMI만 검색
}