# VPC의 ID를 출력합니다.
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# VPC의 CIDR 블록을 출력합니다.
output "vpc_cidr_block" {
  description = "VPC CIDR Block"
  value       = aws_vpc.main.cidr_block
}

# 현재 리전에서 사용 가능한 모든 가용 영역을 출력합니다.
output "available_availability_zones" {
  description = "All available Availability Zones"
  value       = data.aws_availability_zones.available.names
}

# 생성된 서브넷들의 ID를 리스트 형태로 출력합니다.
output "subnets" {
  description = "List of Subnet IDs"
  value       = aws_subnet.subnet.*.id
}

# 생성된 서브넷들의 CIDR 블록을 리스트 형태로 출력합니다.
output "subnets_cidr_blocks" {
  description = "List of Subnet CIDR Blocks"
  value       = aws_subnet.subnet.*.cidr_block
}

# 각 서브넷이 속한 가용 영역을 리스트 형태로 출력합니다.
output "subnets_availability_zones" {
  description = "List of Availability Zones for the Subnets"
  value       = aws_subnet.subnet.*.availability_zone
}

# 현재 리전에서 검색된 Ubuntu 22.04의 최신 AMI ID를 출력합니다.
output "ubuntu_ami_id" {
  description = "The AMI ID for the latest Ubuntu version"
  value       = data.aws_ami.ubuntu.id
}

# 생성된 Ubuntu EC2 인스턴스들의 ID를 리스트 형태로 출력합니다.
output "ubuntu_instances_ids" {
  description = "IDs of the created Ubuntu EC2 instances"
  value       = aws_instance.ubuntu_instance.*.id
}

# 생성된 Ubuntu EC2 인스턴스들의 사설 IP 주소를 리스트 형태로 출력합니다.
output "ubuntu_instances_private_ips" {
  description = "Private IPs of the created Ubuntu EC2 instances"
  value       = aws_instance.ubuntu_instance.*.private_ip
}