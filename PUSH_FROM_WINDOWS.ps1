param([Parameter(Mandatory=$true)][string]$RepoUrl)
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Git for Windows is required: https://git-scm.com/downloads/win' }
if (-not (Test-Path '.git')) { git init; if ($LASTEXITCODE -ne 0) { throw 'git init failed' } }
git add .
if ($LASTEXITCODE -ne 0) { throw 'git add failed' }
git -c user.name='DriveClub Patch' -c user.email='patch@local.invalid' commit -m 'Disable exit modal on Linux'
if ($LASTEXITCODE -ne 0) { throw 'git commit failed (check Git output)' }
git branch -M main
git remote remove origin 2>$null
git remote add origin $RepoUrl
git push -u origin main
if ($LASTEXITCODE -ne 0) { throw 'git push failed (check GitHub authentication and repository)' }
Write-Host 'Push complete. Go to GitHub Actions and run Build Linux AppImage (exit modal disabled).'
