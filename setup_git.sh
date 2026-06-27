#!/usr/bin/env bash
# ============================================================================
#  One-time git setup for the Credit Risk Analysis project (macOS / Linux).
#  Initializes a repo on `main` with a LINEAR history configuration and makes
#  the first commit. Run this once, from inside the project folder:
#      cd /path/to/credit-risk-prediction
#      bash setup_git.sh
# ============================================================================
set -e

echo "Initializing git repository..."
git init
git branch -M main

echo "Configuring identity..."
git config user.name "Bhoomi"
git config user.email "bhoomichavan1@gmail.com"

echo "Enforcing linear history..."
git config pull.rebase true
git config merge.ff only
git config branch.main.mergeOptions "--ff-only"

echo "Making the first commit..."
git add .
git commit -m "chore: initial project scaffold"

echo ""
echo "=== Done. Current history: ==="
git log --oneline
