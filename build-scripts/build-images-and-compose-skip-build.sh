#!/bin/bash

function docker_compose_up() {
  pwd
  cd ./medical-deploy/build-scripts/compose/simple
  docker-compose up -d
  cd ..
  cd ..
  cd ..
  cd ..
}

function build_basic_images() {
  JAR_FILE=$1
  APP_NAME=$2

  docker build -f medical-deploy/build-scripts/docker/basic/Dockerfile \
    --build-arg JAR_FILE=${JAR_FILE} \
    -t ${APP_NAME}:latest \
    -t ${APP_NAME}:simple .
}

# Building the app
cd ..

APP_VERSION=0.0.1-SNAPSHOT

echo "Building Docker images"
build_basic_images medical-monitoring/core/target/monitoring-core-${APP_VERSION}.jar application/medical-monitoring
build_basic_images message-analyzer/core/target/message-analyzer-core-${APP_VERSION}.jar application/message-analyzer
build_basic_images person-service/core/target/person-service-core-${APP_VERSION}.jar application/person-service

# Docker compose
docker_compose_up
