#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Authenticate with GitHub
# gh auth login

# Dynamically fetch repository details from the Git configuration
REPO_URL=$(git config --get remote.origin.url)
REPO_OWNER=$(basename "$(dirname "$REPO_URL")")
REPO_NAME=$(basename -s .git "$REPO_URL")

# Fetch the last 10 workflow runs (sorted in reverse order)
echo "Fetching the last 10 workflow runs for $REPO_OWNER/$REPO_NAME..."
RUN_IDS=$(gh run list --repo "$REPO_OWNER/$REPO_NAME" --limit 100 --json databaseId -q '.[].databaseId' | tac | head -n 10)

# Delete each workflow run
echo "Deleting the last 10 workflow runs..."
for RUN_ID in $RUN_IDS; do
  echo "Deleting workflow run ID: $RUN_ID"
  gh run delete "$RUN_ID" --repo "$REPO_OWNER/$REPO_NAME"
done

echo "✔️ Successfully deleted the last 10 workflow runs."
