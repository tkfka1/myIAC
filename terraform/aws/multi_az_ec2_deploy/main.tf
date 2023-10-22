# VPC 생성
# CIDR 블록이 172.5.0.0/16인 VPC를 생성하며, "main-vpc"라는 이름 태그를 추가한다.
resource "aws_vpc" "main" {
  cidr_block = "172.5.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

# 각 AZ에 대한 서브넷 생성
# 사용 가능한 모든 AZ에 대하여 서브넷을 생성한다. 각 서브넷의 CIDR은 VPC의 CIDR을 기반으로 분할된다.
# 서브넷은 공용 IP를 자동으로 받지 않도록 설정되어 있다(map_public_ip_on_launch 주석 처리).
resource "aws_subnet" "subnet" {
  count             = length(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  # map_public_ip_on_launch = true
  tags = {
    Name = "subnet-${data.aws_availability_zones.available.names[count.index]}"
  }
}

# EC2 인스턴스 생성
# 각 AZ에 대해서 3개의 EC2 인스턴스를 생성한다. 이러한 인스턴스들은 Ubuntu 22.04를 사용하며, t3.micro 유형이다.
# 이전 생성한 aws_subnet.subnet의 id를 참조하며 순차적으로 다른 서브넷에 할당
resource "aws_instance" "ubuntu_instance" {
  count         = length(data.aws_availability_zones.available.names) * 3
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = element(aws_subnet.subnet.*.id, count.index % length(data.aws_availability_zones.available.names))

  tags = {
    Name = "ubuntu-instance-${count.index}"
  }
}