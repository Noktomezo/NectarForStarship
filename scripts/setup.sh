#!/usr/bin/env bash

clear

BASE_URL="https://raw.githubusercontent.com/Noktomezo/FelineForStarship/refs/heads/main"
CONFIG_DIR="$HOME/.config"

# Colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BOLD="\033[1m"
RESET="\033[0m"

if command -v starship >/dev/null 2>&1; then
    echo -e "${GREEN}Starship is installed. Proceeding with preset installation.${RESET}"
else
    echo -e "${RED}Starship is NOT installed.${RESET}"
    echo -e "${RED}Please install Starship first from https://starship.rs/ and add it to your PATH.${RESET}"
    echo -e "${RED}Installation will continue, but the preset won't take effect until Starship is installed.${RESET}"
    sleep 3
fi

if [ ! -d "$CONFIG_DIR" ]; then
    echo -e "${YELLOW}Starship config directory does not exist${RESET}"
    echo -e "${YELLOW}Creating directory...${RESET}"
    mkdir -p "$CONFIG_DIR"
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
THEMES_DIR="$SCRIPT_DIR/../themes"

valid=false
while [ "$valid" = false ]; do
    echo -e "\n${BOLD}Select preset to install:${RESET}"
    echo -e "${GREEN}[1]${RESET} ${BOLD}Standard preset (${YELLOW}Requires Nerd Font${RESET})${RESET}"
    echo -e "${GREEN}[2]${RESET} ${BOLD}Emoji preset${RESET}"
    echo -e "${GREEN}[3]${RESET} ${BOLD}Plain text preset${RESET}"
    echo -ne "\n${BOLD}Enter your choice (${GREEN}1-3${RESET}): ${RESET}"
    read -r choice
    
    choice=$(echo "$choice" | xargs)
    
    if [ -z "$choice" ]; then
        clear
        echo -e "${RED}No input provided. Please enter 1, 2, or 3.${RESET}"
        continue
    fi
    
    case $choice in
        1)
            url="$BASE_URL/themes/feline.toml"
            valid=true
            echo -e "${GREEN}Selected \"Standard preset\"${RESET}"
        ;;
        2)
            url="$BASE_URL/themes/feline-emoji.toml"
            valid=true
            echo -e "${GREEN}Selected \"Emoji preset\"${RESET}"
        ;;
        3)
            url="$BASE_URL/themes/feline-plain-text.toml"
            valid=true
            echo -e "${GREEN}Selected \"Plain text preset\"${RESET}"
        ;;
        *)
            clear
            echo -e "${RED}Invalid choice '$choice'. Please enter 1, 2, or 3.${RESET}"
        ;;
    esac
done

{
    filename=$(basename "$url")
    echo -e "\n${YELLOW}Downloading and installing from $filename...${RESET}"
    curl -s -L "$url" -o "$CONFIG_DIR/starship.toml"
    echo -e "\n${GREEN}Installation complete! (Shell restart may be required)${RESET}"
    } || {
    echo -e "\n${RED}Error downloading preset: $($_.Exception.Message)${RESET}"
    echo -e "\n${YELLOW}Check your internet or repo URL.${RESET}"
}

if ! command -v starship >/dev/null 2>&1; then
    echo -e "\n${YELLOW}Reminder: Install Starship to activate the preset!${RESET}"
fi
