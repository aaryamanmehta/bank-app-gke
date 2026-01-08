#!/usr/bin/env bash
set -euo pipefail

# Creates an Artifact Registry Docker repository for the GCP project
PROJECT=bank-app-gke
LOCATION=us-east1
REPO=bank-artifacts

echo "Setting gcloud project to $PROJECT"
gcloud config set project "$PROJECT"

echo "Creating Artifact Registry repo $REPO in $LOCATION (if not exists)"
gcloud artifacts repositories describe "$REPO" --location="$LOCATION" >/dev/null 2>&1 || \
  gcloud artifacts repositories create "$REPO" --repository-format=docker --location="$LOCATION" --description="Docker repo for bank-app-gke"

echo "Repository ready: $LOCATION-docker.pkg.dev/$PROJECT/$REPO"
