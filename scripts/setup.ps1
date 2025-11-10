Clear-Host

$BASE_URL = "https://raw.githubusercontent.com/Noktomezo/FelineForStarship/refs/heads/main"
$CONFIG_DIR = "$HOME\.config"

# Colors
$RED = "$($PSStyle.Foreground.Red)$($PSStyle.Bold)"
$GREEN = "$($PSStyle.Foreground.Green)$($PSStyle.Bold)"
$YELLOW = "$($PSStyle.Foreground.Yellow)$($PSStyle.Bold)"
$BOLD = "$($PSStyle.Bold)"
$RESET = "$($PSStyle.Reset)"

if (Get-Command starship -ErrorAction SilentlyContinue) {
  Write-Host "$($GREEN)Starship is installed. Proceeding with preset installation.$($RESET)"
}
else {
  Write-Host "$($RED)Starship is NOT installed.$($RESET)"
  Write-Host "$($RED)Please install Starship first from https://starship.rs/ and add it to your PATH.$($RESET)"
  Write-Host "$($RED)Installation will continue, but the preset won't take effect until Starship is installed.$($RESET)"
  Start-Sleep -Seconds 3
}

if (-not (Test-Path $CONFIG_DIR)) {
  Write-Host "$($RED)Starship config directory does not exist.$($RESET)"
  Write-Host "$($YELLOW)Creating directory...$($RESET)`n"
  New-Item -Path $CONFIG_DIR -ItemType Directory -Force | Out-Null
}

$valid = $false
while (-not $valid) {
  Write-Host "`n$($BOLD)Select preset to install:$($RESET)"
  Write-Host "$($GREEN)[1]$($RESET) $($BOLD)Standard preset ($($YELLOW)Requires Nerd Font$($RESET))$($RESET)"
  Write-Host "$($GREEN)[2]$($RESET) $($BOLD)Emoji preset$($RESET)"
  Write-Host "$($GREEN)[3]$($RESET) $($BOLD)Plain text preset$($RESET)"
  $choice = Read-Host "`n$($BOLD)Enter your choice ($($GREEN)1-3$($RESET))"

  $choice = $choice.Trim()

  if ([string]::IsNullOrEmpty($choice)) {
    Clear-Host
    Write-Host "$($RED)No input provided. Please enter 1, 2, or 3.$($RESET)"
    continue
  }

  switch ($choice) {
    "1" {
      $url = "$BASE_URL/themes/feline.toml"
      $valid = $true
      Write-Host "$($GREEN)Selected `"Standard preset`"$($RESET)"
    }
    "2" {
      $url = "$BASE_URL/themes/feline-emoji.toml"
      $valid = $true
      Write-Host "$($GREEN)Selected `"Emoji preset`"$($RESET)"
    }
    "3" {
      $url = "$BASE_URL/themes/feline-plain-text.toml"
      $valid = $true
      Write-Host "$($GREEN)Selected `"Plain text preset`"$($RESET)"
    }
    default {
      Clear-Host
      Write-Host "$($RED)Invalid choice '$choice'. Please enter 1, 2, or 3.$($RESET)"
    }
  }
}

Write-Host "`n$($YELLOW)Downloading and installing $([System.IO.Path]::GetFileName($url))...$($RESET)"
try {
  Invoke-WebRequest -Uri $url -OutFile "$CONFIG_DIR\starship.toml" -UseBasicParsing
  Write-Host "$($GREEN)Installation complete! (Shell restart may be required)$($RESET)"
}
catch {
  Write-Host "$($RED)Error downloading preset: $($_.Exception.Message)$($RESET)"
  Write-Host "$($YELLOW)Check your internet or repo URL.$($RESET)"
}

if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
  Write-Host "`n$($YELLOW)Reminder: Install Starship to activate the preset!$($RESET)`n"
}
