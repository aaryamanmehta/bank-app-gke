#!/usr/bin/env bash
set -euo pipefail

# Create a GitHub repository named bank-app-gke and push current workspace.
# Requires `gh` (GitHub CLI) authenticated.

REPO_NAME=bank-app-gke

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI not found. Install from https://cli.github.com/ and authenticate with 'gh auth login'"
  exit 2
fi

echo "Creating GitHub repo $REPO_NAME (public) and pushing current directory"
gh repo create "$REPO_NAME" --public --source . --remote origin --push

echo "Repository created and pushed to GitHub as $REPO_NAME"
