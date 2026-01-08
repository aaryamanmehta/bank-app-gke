#!/usr/bin/env bash
set -euo pipefail

# Build and push backend and frontend images to Artifact Registry.
# Frontend uses a nonstandard Dockerfile name; we pass -f explicitly.

PROJECT=bank-app-gke
LOCATION=us-east1
REPO=bank-artifacts

DOCKER_BUILD_PLATFORM="linux/amd64"

BACKEND_IMAGE="$LOCATION-docker.pkg.dev/$PROJECT/$REPO/bank-backend:latest"
FRONTEND_IMAGE="$LOCATION-docker.pkg.dev/$PROJECT/$REPO/bank-frontend:latest"

echo "Configuring docker auth for Artifact Registry"
gcloud auth configure-docker "$LOCATION-docker.pkg.dev" --quiet

echo "Building backend image"
docker build --platform "$DOCKER_BUILD_PLATFORM" -t "$BACKEND_IMAGE" -f bank-api-gke/Dockerfile ./bank-api-gke
echo "Pushing backend image"
docker push "$BACKEND_IMAGE"

echo "Building frontend image (Dockerfile-before-https-first)"
docker build --platform "$DOCKER_BUILD_PLATFORM" -t "$FRONTEND_IMAGE" -f bank-web-gke/Dockerfile-before-https-first ./bank-web-gke
echo "Pushing frontend image"
docker push "$FRONTEND_IMAGE"

echo "Images pushed:\n  $BACKEND_IMAGE\n  $FRONTEND_IMAGE"
