#!/usr/bin/env bash

# start.sh
# 서버 구동을 위한 스크립트
REPOSITORY=/home/ec2-user/app
PROJECT_NAME=practice

echo "> Build 파일 복사"
echo "> cp $REPOSITORY/deploy/*.jar $REPOSITORY/"

cp $REPOSITORY/deloy/*.jar $REPOSITORY/

# ✨ 이 부분이 안되면 명령어 실행해보시고, jar 파일의 PID를 가져올 수 있도록 변경해주세요.
CURRENT_PID=$(lsof -t -i:8080)

echo "현재 구동 중인 애플리케이션 pid: $CURRENT_PID"

# 실행 중이라면 종료 후 재실행
if [ -z "$CURRENT_PID" ]; then
  echo "> 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> 새 어플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"

chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"


nohup java -jar \
    $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &