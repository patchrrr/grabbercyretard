@echo off
setlocal EnableExtensions EnableDelayedExpansion

cd /d "%~dp0"

where git >nul 2>nul
if errorlevel 1 (
  echo Git is not installed or not on PATH.
  exit /b 1
)

set "COMMIT_MESSAGE=%~1"
if not defined COMMIT_MESSAGE set "COMMIT_MESSAGE=Publish polished grabber.cy analysis repo"

if not exist ".git" (
  git init
)

for /f "delims=" %%i in ('git config user.name 2^>nul') do set "GIT_NAME=%%i"
for /f "delims=" %%i in ('git config user.email 2^>nul') do set "GIT_EMAIL=%%i"

if not defined GIT_NAME (
  set /p GIT_NAME=Enter your Git author name: 
  if not defined GIT_NAME (
    echo No author name entered. Stopping.
    exit /b 1
  )
  git config user.name "!GIT_NAME!"
)

if not defined GIT_EMAIL (
  set /p GIT_EMAIL=Enter your Git author email: 
  if not defined GIT_EMAIL (
    echo No author email entered. Stopping.
    exit /b 1
  )
  git config user.email "!GIT_EMAIL!"
)

set "CURRENT_REMOTE="
for /f "delims=" %%i in ('git remote get-url origin 2^>nul') do set "CURRENT_REMOTE=%%i"

if defined CURRENT_REMOTE (
  echo Current origin: !CURRENT_REMOTE!
)

set /p REPO_URL=Enter the GitHub repository URL for origin (press Enter to keep current): 

if defined REPO_URL (
  if defined CURRENT_REMOTE (
    git remote set-url origin "!REPO_URL!"
  ) else (
    git remote add origin "!REPO_URL!"
  )
) else if not defined CURRENT_REMOTE (
  echo No remote entered. Stopping.
  exit /b 1
)

git add -A
git diff --cached --quiet
if errorlevel 1 (
  git commit -m "!COMMIT_MESSAGE!"
  if errorlevel 1 (
    echo Commit failed. Check your Git author settings and staged files.
    exit /b 1
  )
) else (
  echo No staged changes to commit. Continuing to push current HEAD.
)

git branch -M main

git push -u origin main

if errorlevel 1 (
  echo Push failed. Check the remote URL and your GitHub authentication.
  exit /b 1
)

echo Published to GitHub.
