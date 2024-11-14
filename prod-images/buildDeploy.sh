#!/bin/bash

SRC_DIR="../src"
LARAVEL_DIR="../src/laravel"
BASE_DIR=".."
DOCKER_REPO="YOUR_REPO"
TEMP_DIR="../temp"

mkdir -p "$TEMP_DIR"

if [ -d "$LARAVEL_DIR/node_modules" ] && [ -d "$LARAVEL_DIR/vendor" ]; then
    read -p "Are node_modules and vendor folders 100% up to date? (y/n): " confirmation
    if [ "$confirmation" != "y" ]; then
        echo "Please update node_modules and vendor folders before proceeding."
        exit 1
    fi
else
    echo "Either node_modules or vendor folder is missing in $LARAVEL_DIR."
    exit 1
fi

read -p "Enter image tag: " image_tag

cd "$LARAVEL_DIR"

if [ -d "$LARAVEL_DIR/node_modules" ]; then
    echo "Removing node_modules requires elevated permissions."
    sudo rm -rf "$LARAVEL_DIR/node_modules"
fi

cd -

ln -sf "$SRC_DIR" "$BASE_DIR/prod-images/base/src"
ln -sf "$BASE_DIR/prod-images/nginx" "$BASE_DIR/prod-images/base/nginx"

for image in "base" "nginx"; do
    echo "Building and pushing $DOCKER_REPO/custom-$image:$image_tag..."

    docker build --no-cache -t "$DOCKER_REPO/custom-$image:$image_tag" --platform linux/arm64 -f "$BASE_DIR/prod-images/$image/Dockerfile" "$BASE_DIR"

    if ! docker login; then
        echo "Failed to login to Docker Hub."
        exit 1
    fi

    docker push "$DOCKER_REPO/custom-$image:$image_tag"
done

echo "Images pushed to $DOCKER_REPO with tag $image_tag."
