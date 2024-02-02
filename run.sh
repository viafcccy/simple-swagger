#!/bin/bash

# 将swagger文档移到docs下
# cp /xxx/*.swagger.json /xxx/swagger/docs

# 定义容器名和镜像名
CONTAINER_NAME=swagger_container
IMAGE_NAME=swagger_image

# 检查容器是否存在
if [ $(docker ps -a -q -f name=^/"${CONTAINER_NAME}"$) ]; then
    # 停止并移除现有容器
    echo "容器 ${CONTAINER_NAME} 已存在. 正在停止并移除..."
    docker stop "${CONTAINER_NAME}"
    docker rm "${CONTAINER_NAME}"
    echo "移除完成."
fi

# 检查镜像是否存在，如果存在，则移除
if [ $(docker images -q ${IMAGE_NAME}) ]; then
    echo "镜像 ${IMAGE_NAME} 已存在. 正在移除..."
    docker rmi "${IMAGE_NAME}"
    echo "移除完成."
fi

# 根据Dockerfile构建新镜像
echo "正在构建新镜像..."
docker build -t "${IMAGE_NAME}" .

# 启动新容器
docker run --name="${CONTAINER_NAME}" -d -p 0.0.0.0:9020:8080 ${IMAGE_NAME}

echo "脚本执行完毕."
