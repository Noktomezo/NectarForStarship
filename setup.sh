#!/usr/bin/env bash

clear

if command -v starship >/dev/null 2>&1; then
    echo -e "\033[1;32mStarship is installed. Proceeding with preset installation.\033[0m"
else
    echo -e "\033[1;31mStarship is NOT installed.\033[0m"
    echo -e "\033[1;33mPlease install Starship first from https://starship.rs/ and add it to your PATH.\033[0m"
    echo -e "\033[1;33mInstallation will continue, but the preset won't take effect until Starship is installed.\033[0m"
    sleep 3
fi

if [ ! -d "$HOME/.config" ]; then
    echo -e "\033[1;31mStarship config directory does not exist\033[0m"
    echo -e "\033[1;33mCreating directory...\033[0m"
    mkdir -p "$HOME/.config"
fi

valid=false
while [ "$valid" = false ]; do
    echo -e "\n\033[1;34mSelect preset to install:\033[0m"
    echo -e "[1] \033[1;34mDefault preset (feline.toml)\033[0m"
    echo -e "[2] \033[1;34mEmoji preset (feline-emoji.toml)\033[0m"
    echo -e "[3] \033[1;34mPlain text preset (feline-plain-text.toml)\033[0m"
    echo -ne "\n\033[1;34mEnter your choice (1-3): \033[0m"
    read -r choice
    
    choice=$(echo "$choice" | xargs)
    
    if [ -z "$choice" ]; then
        clear
        echo -e "\033[1;31mNo input provided. Please enter 1, 2, or 3.\033[0m"
        continue
    fi
    
    case $choice in
        1)
            config_file="themes/feline.toml"
            valid=true
            echo -e "\033[1;32mSelected: Default preset\033[0m"
        ;;
        2)
            config_file="themes/feline-emoji.toml"
            valid=true
            echo -e "\033[1;32mSelected: Emoji preset\033[0m"
        ;;
        3)
            config_file="themes/feline-plain-text.toml"
            valid=true
            echo -e "\033[1;32mSelected: Plain text preset\033[0m"
        ;;
        *)
            clear
            echo -e "\033[1;31mInvalid choice '$choice'. Please enter 1, 2, or 3.\033[0m"
        ;;
    esac
done

echo -e "\n\033[1;33mCopying $(basename "$config_file") to ~/.config/starship.toml...\033[0m"
cp "$config_file" "$HOME/.config/starship.toml"
echo -e "\033[1;32mInstallation complete! (Shell restart may be required)\033[0m"

if ! command -v starship >/dev/null 2>&1; then
    echo -e "\n\033[1;33mReminder: Install Starship to activate the preset!\033[0m"
fi
