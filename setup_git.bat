@echo off
REM ===========================================================================
REM  One-time git setup for the Credit Risk Analysis project (Windows).
REM  Initializes a repo on `main` with a LINEAR history configuration and
REM  makes the first commit. Run this once, from inside the project folder:
REM      cd "...\credit-risk-prediction"
REM      setup_git.bat
REM ===========================================================================

echo Initializing git repository...
git init
git branch -M main

echo Configuring identity...
git config user.name "Bhoomi"
git config user.email "bhoomichavan1@gmail.com"

echo Enforcing linear history...
git config pull.rebase true
git config merge.ff only
git config branch.main.mergeOptions "--ff-only"

echo Making the first commit...
git add .
git commit -m "chore: initial project scaffold"

echo.
echo === Done. Current history: ===
git log --oneline
