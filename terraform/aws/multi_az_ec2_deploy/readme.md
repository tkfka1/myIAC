1. VPC 생성 (ap-northeast-2, 172.5.0.0/16)
   1. "ap-northeast-2a"
   2. "ap-northeast-2b"
   3. "ap-northeast-2c"
   4. "ap-northeast-2d"
2. Subnet는 az별로 생성
   1. 172.5.0.0/24
   2. 172.5.1.0/24
   3. 172.5.2.0/24
   4. 172.5.3.0/24
3. EC2 생성 (az별로 3개를 생성)
   1. ubuntu 22.04
   2. t3.micro
