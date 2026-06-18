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

git remote get-url origin >nul 2>nul
if errorlevel 1 (
  set /p REPO_URL=Enter the GitHub repository URL for origin: 
  if not defined REPO_URL (
    echo No remote entered. Stopping.
    exit /b 1
  )
  git remote add origin "!REPO_URL!"
)

git add -A
git diff --cached --quiet
if not errorlevel 1 (
  echo No staged changes to commit.
  exit /b 0
)

git commit -m "!COMMIT_MESSAGE!"
if errorlevel 1 (
  echo Commit failed. Check your Git author settings and staged files.
  exit /b 1
)

git branch -M main

git push -u origin main

if errorlevel 1 (
  echo Push failed. Check the remote URL and your GitHub authentication.
  exit /b 1
)

echo Published to GitHub.
