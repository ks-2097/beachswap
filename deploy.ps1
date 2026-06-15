# BeachSwap — one-command deploy to GitHub Pages (free public hosting).
# Prereq (one-time, ~30s): run  gh auth login  and follow the browser prompt.
# Then just run:  powershell -ExecutionPolicy Bypass -File deploy.ps1

$ErrorActionPreference = "Stop"
$repo = "beachswap"

# make sure gh is on PATH for this session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "Checking GitHub login..." -ForegroundColor Cyan
gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "`nYou're not logged in to GitHub yet. Run this once, then re-run deploy.ps1:" -ForegroundColor Yellow
  Write-Host "    gh auth login`n" -ForegroundColor White
  exit 1
}

$user = (gh api user --jq ".login").Trim()
Write-Host "Logged in as $user" -ForegroundColor Green

# commit any pending changes
git add -A
git commit -m "Deploy BeachSwap" 2>$null | Out-Null

# create the repo + push (idempotent: skips creation if it already exists)
$exists = (gh repo view "$user/$repo" 2>$null)
if (-not $exists) {
  Write-Host "Creating public repo $user/$repo and pushing..." -ForegroundColor Cyan
  gh repo create $repo --public --source=. --remote=origin --push
} else {
  Write-Host "Repo exists — pushing latest..." -ForegroundColor Cyan
  git push origin HEAD:main 2>$null
}

# enable GitHub Pages from main / root
Write-Host "Enabling GitHub Pages..." -ForegroundColor Cyan
try {
  gh api -X POST "repos/$user/$repo/pages" -f "source[branch]=main" -f "source[path]=/" 2>$null | Out-Null
} catch {
  # already enabled — make sure it points at main/root
  gh api -X PUT "repos/$user/$repo/pages" -f "source[branch]=main" -f "source[path]=/" 2>$null | Out-Null
}

$url = "https://$user.github.io/$repo/"
Write-Host "`n=======================================================" -ForegroundColor Green
Write-Host " BeachSwap is deploying!" -ForegroundColor Green
Write-Host " Your public link (live in ~1 minute):" -ForegroundColor Green
Write-Host "   $url" -ForegroundColor White
Write-Host "=======================================================" -ForegroundColor Green
Write-Host " Share that link with your friends and the club owner."
Write-Host " Owner pitch:  ${url}owner-pitch.html"
