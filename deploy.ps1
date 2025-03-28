# Deploy script
Write-Host "Starting Netlify deployment..." -ForegroundColor Cyan

# Check Git
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Git..." -ForegroundColor Yellow
    winget install --id Git.Git -e --source winget
}

# Check Node.js
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Node.js..." -ForegroundColor Yellow
    winget install OpenJS.NodeJS
}

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
npm install

# Git init
Write-Host "Initializing Git repository..." -ForegroundColor Yellow
git init
git add .
git commit -m "Initial commit"

# GitHub setup
Write-Host "Please:" -ForegroundColor Yellow
Write-Host "1. Go to GitHub (https://github.com)" -ForegroundColor Yellow
Write-Host "2. Create new repository" -ForegroundColor Yellow
Write-Host "3. Copy repository URL" -ForegroundColor Yellow

$repoUrl = Read-Host "Paste your GitHub repository URL"

# Push to GitHub
git remote add origin $repoUrl
git push -u origin main

# Netlify setup
Write-Host "Now:" -ForegroundColor Cyan
Write-Host "1. Opening Netlify in browser" -ForegroundColor Cyan
Write-Host "2. Sign in/up to Netlify" -ForegroundColor Cyan
Write-Host "3. Click 'Add new site' -> 'Import project'" -ForegroundColor Cyan
Write-Host "4. Select your GitHub repository" -ForegroundColor Cyan
Write-Host "5. Click 'Deploy site'" -ForegroundColor Cyan

Start-Process "https://app.netlify.com"

# Get site URL
Write-Host "After deployment:" -ForegroundColor Yellow
Write-Host "1. Copy your Netlify site URL" -ForegroundColor Yellow
$siteUrl = Read-Host "Paste your Netlify site URL"

# Check deployment
Write-Host "Checking deployment..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri $siteUrl -Method Get
    if ($response.StatusCode -eq 200) {
        Write-Host "Site is live at: $siteUrl" -ForegroundColor Green
    }
} catch {
    Write-Host "Error checking site: $_" -ForegroundColor Red
}

Write-Host "Deployment complete!" -ForegroundColor Green 