#!/bin/bash

SRC_DIR="../src"
LARAVEL_DIR="$SRC_DIR/laravel"
BASE_DIR=".."
DOCKER_REPO="deampuleadd"
TEMP_DIR="../temp"

mkdir -p "$TEMP_DIR"

if [ ! -d "$LARAVEL_DIR/node_modules" ] || [ ! -d "$LARAVEL_DIR/vendor" ]; then
    echo "Either node_modules or vendor folder is missing in $LARAVEL_DIR."
    exit 1
fi

read -p "Are node_modules and vendor folders 100% up to date? (y/n): " confirmation
[ "$confirmation" != "y" ] && echo "Please update node_modules and vendor folders before proceeding." && exit 1

read -p "Enter image tag: " image_tag

ln -sf "$SRC_DIR" "$BASE_DIR/prod-images/base/src"
ln -sf "$BASE_DIR/prod-images/nginx" "$BASE_DIR/prod-images/base/nginx"

if ! docker login; then
    echo "Failed to login to Docker Hub."
    exit 1
fi

build_and_push() {
    image=$1
    docker build --no-cache -t "$DOCKER_REPO/custom-$image:$image_tag" \
        --platform linux/arm64 \
        -f "$BASE_DIR/prod-images/$image/Dockerfile" "$BASE_DIR" \
        && docker push "$DOCKER_REPO/custom-$image:$image_tag"
}

build_and_push base &
build_and_push nginx &

wait

echo "All images pushed to $DOCKER_REPO with tag $image_tag."
