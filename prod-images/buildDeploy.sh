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

declare -A image_prefix_map
images=(base nginx phpcli phpfpm redis)

for image in "${images[@]}"; do
    echo ""
    echo "Where do you want to push image \"$image\"?"
    echo "1) custom-$image"
    echo "2) premium-$image"
    echo "3) skip"
    read -p "Enter 1, 2, or 3: " choice

    case "$choice" in
        1) image_prefix_map["$image"]="custom" ;;
        2) image_prefix_map["$image"]="premium" ;;
        3) image_prefix_map["$image"]="skip" ;;
        *) echo "Invalid option. Skipping $image." ; image_prefix_map["$image"]="skip" ;;
    esac
done

build_and_push() {
  image=$1
  prefix=$2
  full_tag="$DOCKER_REPO/$prefix-$image:$image_tag"

  df="$BASE_DIR/prod-images/$image/Dockerfile"
  ctx="$(dirname "$df")"

  echo "→ Building $image from context $ctx"
  docker build --no-cache \
    --platform linux/arm64 \
    -t "$full_tag" \
    -f "$df" \
    "$ctx" \
  && docker push "$full_tag"
}


for image in "${images[@]}"; do
    prefix="${image_prefix_map[$image]}"
    if [ "$prefix" != "skip" ]; then
        build_and_push "$image" "$prefix" &
    else
        echo "Skipping image \"$image\"."
    fi
done

wait

echo "All selected images pushed with tag $image_tag."
