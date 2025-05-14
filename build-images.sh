#!/bin/bash

set -e

docker build -t php-cli-local:latest ./phpcli
docker build -t php-fpm-local:latest ./phpfpm

echo "✅ Images built successfully."
