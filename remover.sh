#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Authenticate with GitHub
# gh auth login

# Repository details
REPO_OWNER="Georges034302" # Replace with your GitHub username or organization
REPO_NAME="azure-aci-acr-workflow"   # Replace with your repository name

# Fetch the last 10 workflow runs (sorted in reverse order)
echo "Fetching the last 20 workflow runs..."
RUN_IDS=$(gh run list --repo "$REPO_OWNER/$REPO_NAME" --limit 100 --json databaseId -q '.[].databaseId' | tac | head -n 8)

# Delete each workflow run
echo "Deleting the last 20 workflow runs..."
for RUN_ID in $RUN_IDS; do
  echo "Deleting workflow run ID: $RUN_ID"
  gh run delete "$RUN_ID" --repo "$REPO_OWNER/$REPO_NAME"
done

echo "✔️ Successfully deleted the last 20 workflow runs."
