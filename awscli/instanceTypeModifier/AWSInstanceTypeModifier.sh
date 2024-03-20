#!/bin/bash

# 사용할 AWS CLI 프로필 이름, 지정하지 않으면 default 프로필 사용
PROFILE="default"

# 인스턴스 ID와 변경할 인스턴스 타입을 지정하는 연관배열
declare -A INSTANCES
INSTANCES["i-01234567890123456"]="t2.micro"
INSTANCES["i-01234567890123456"]="t2.micro"
INSTANCES["i-01234567890123456"]="t2.micro"
INSTANCES["i-01234567890123456"]="t2.micro"

# 인스턴스를 중지하고, 타입 변경 후 재시작하는 함수
modify_and_restart_instance() {
    local INSTANCE_ID=$1
    local INSTANCE_TYPE=$2
    local PROFILE_OPTION="--profile $PROFILE"
    
    if [ "$PROFILE" == "default" ]; then
        PROFILE_OPTION=""
    fi

    local TAG_VALUE=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].Tags[?Key==`Name`].Value' --output text --no-cli-pager $PROFILE_OPTION)
    echo "인스턴스 $INSTANCE_ID 의 Name 태그 값은 '$TAG_VALUE' 입니다."

    local CURRENT_STATE=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].State.Name' --output text)
    echo "인스턴스 $INSTANCE_ID 의 현재 상태: $CURRENT_STATE"

    local CURRENT_TYPE=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].InstanceType' --output text)
    echo "인스턴스 $INSTANCE_ID 의 현재 타입: $CURRENT_TYPE"

    aws ec2 stop-instances --no-cli-pager  --instance-ids $INSTANCE_ID $PROFILE_OPTION

    echo "인스턴스 $INSTANCE_ID 중지 대기 중"

    aws ec2 wait instance-stopped --no-cli-pager  --instance-ids $INSTANCE_ID $PROFILE_OPTION

    aws ec2 modify-instance-attribute --no-cli-pager  --instance-id $INSTANCE_ID --instance-type "{\"Value\": \"$INSTANCE_TYPE\"}" $PROFILE_OPTION

    echo "인스턴스 $INSTANCE_ID 타입 변경 완료 $INSTANCE_TYPE"

    aws ec2 start-instances --no-cli-pager  --instance-ids $INSTANCE_ID $PROFILE_OPTION

    echo "인스턴스 $INSTANCE_ID 재시작 대기 중"

    aws ec2 wait instance-running --no-cli-pager  --instance-ids $INSTANCE_ID $PROFILE_OPTION

    echo "인스턴스 $INSTANCE_ID 의 타입 변경을 완료하고 재시작하였습니다."
}

# 각 인스턴스에 대해 병렬로 실행
for INSTANCE_ID in "${!INSTANCES[@]}"; do
    echo "인스턴스 $INSTANCE_ID 의 타입을 ${INSTANCES[$INSTANCE_ID]} 로 변경합니다."
    modify_and_restart_instance $INSTANCE_ID ${INSTANCES[$INSTANCE_ID]} &
done

# 모든 백그라운드 작업이 완료될 때까지 기다림
wait
