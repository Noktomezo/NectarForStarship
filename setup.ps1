Clear-Host

if (Get-Command starship -ErrorAction SilentlyContinue) {
  Write-Host "`e[1;32mStarship is installed. Proceeding with preset installation.`e[0m"
}
else {
  Write-Host "`e[1;31mStarship is NOT installed.`e[0m"
  Write-Host "`e[1;33mPlease install Starship first from https://starship.rs/ and add it to your PATH.`e[0m"
  Write-Host "`e[1;33mInstallation will continue, but the preset won't take effect until Starship is installed.`e[0m"
  Start-Sleep -Seconds 3
}

$configDir = "$HOME\.config"
if (-not (Test-Path $configDir)) {
  Write-Host "`e[1;31mStarship config directory does not exist`e[0m"
  Write-Host "`e[1;33mCreating directory...`e[0m`n"
  New-Item -Path $configDir -ItemType Directory -Force | Out-Null
}

$valid = $false
while (-not $valid) {
  Write-Host "`n`e[1;34mSelect preset to install:`e[0m"
  Write-Host "`e[1;32m[1]`e[0m `e[1;34mDefault preset (feline.toml)`e[0m"
  Write-Host "`e[1;32m[2]`e[0m `e[1;34mEmoji preset (feline-emoji.toml)`e[0m"
  Write-Host "`e[1;32m[3]`e[0m `e[1;34mPlain text preset (feline-plain-text.toml)`e[0m"
  $choice = Read-Host "`n`e[1;34mEnter your choice (1-3)`e[0m"

  $choice = $choice.Trim()

  if ([string]::IsNullOrEmpty($choice)) {
    Clear-Host
    Write-Host "`e[1;31mNo input provided. Please enter 1, 2, or 3.`e[0m"
    continue
  }

  switch ($choice) {
    "1" {
      $config_file = "themes\feline.toml";
      $valid = $true
      Write-Host "`e[1;32mSelected: Default preset`e[0m"
    }
    "2" {
      $config_file = "themes\feline-emoji.toml";
      $valid = $true
      Write-Host "`e[1;32mSelected: Emoji preset`e[0m"
    }
    "3" {
      $config_file = "themes\feline-plain-text.toml";
      $valid = $true
      Write-Host "`e[1;32mSelected: Plain text preset`e[0m"
    }
    default {
      Clear-Host
      Write-Host "`e[1;31mInvalid choice '$choice'. Please enter 1, 2, or 3.`e[0m"
    }
  }
}

Write-Host "`n`e[1;33mCopying $((Get-Item $config_file).Name) to $HOME\.config\starship.toml...`e[0m"
Copy-Item -Path $config_file -Destination "$HOME\.config\starship.toml" -Force
Write-Host "`e[1;32mInstallation complete! (Shell restart may be required)`e[0m"

if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
  Write-Host "`n`e[1;33mReminder: Install Starship to activate the preset!`e[0m"
}
