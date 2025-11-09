# 🌠🙀 Feline For Starship

A clean, vivid prompt preset for Starship. Built with high-contrast palettes inspired by Catppuccin, but more compact and vibrant. Provides three variants: Nerd Font icons, emojis, or plain text.

Requires: Starship 1.0+

## Installation

1. Install Starship: [starship.rs](https://starship.rs/guide/#🚀-installation).

2. Download the installer: [install.sh](install.sh) (Bash) or [install.ps1](install.ps1) (PowerShell).

3. Run it and select a variant:
   - 1: Default (Nerd Font) — `feline.toml`
   - 2: Emoji — `feline-emoji.toml`
   - 3: Plain text — `feline-plain-text.toml`

   The script copies the config to `~/.config/starship.toml` (or `%USERPROFILE%\.config\starship.toml` on Windows).

4. Add to your shell profile (e.g., `.zshrc`):
   ```
   eval "$(starship init zsh)"
   ```

5. Reload shell.

## Palettes

Four schemes with consistent keys (e.g., `goldenspark` for branches, `lime_zest` for success). Define at the top of your config.

| Palette       | Base Theme      |
| ------------- | --------------- |
| vivid_sunset  | Warm glow       |
| electric_dawn | Neon burst      |
| radiant_storm | Thunder energy  |
| blaze_echo    | Fiery afterglow |

Edit `palette` key in `~/.config/starship.toml` to change it.

## Variants

- **Default**: Nerd Font icons (e.g., 󰱒 for staged). Requires [Nerd Font](https://www.nerdfonts.com/).
- **Emoji**: Unicode emojis (e.g., ✅ for staged).
- **Plain text**: ASCII/Unicode (e.g., + for staged).

All include directory truncation, git branch/status, and vim support.

## License

MIT. See [LICENSE](LICENSE).
