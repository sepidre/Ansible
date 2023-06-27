#!/usr/bin/env bash

# A script for the quick setup of Zsh shell with Prezto, several useful plugins and an awesome theme.
# 
# Based on https://github.com/gustavohellwig/gh-zsh

#--------------------------------------------------
# Shell Configurations
#--------------------------------------------------
OS="$(uname)"
if [[ "$OS" == "Linux" ]] ; then
    sudo usermod -s /usr/bin/zsh $(whoami) &> /dev/null
    sudo usermod -s /usr/bin/zsh sepidre &> /dev/null
    if mv -n ~/.zshrc ~/.zshrc_backup_$(date +"%Y-%m-%d_%H:%M:%S") &> /dev/null; then
        echo -e "\n--> Backing up the current .zshrc config to .zshrc_backup-date"
    fi
    #--------------------------------------------------
    # LSDeluxe
    #--------------------------------------------------
    echo -e "\nInstalling LSDeluxe"
    curl -sS https://webi.sh/lsd | sh

    #--------------------------------------------------
    # Prezto and plugins
    #--------------------------------------------------
    echo -e "\nInstalling Prezto"
    # Install Prezto (by downloading the repo into .zprezto folder in our home directory): https://github.com/sorin-ionescu/prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    # Create symlinks to link Zsh to Prezto configurations (this will overwrite default Zsh files)
    echo -e "\nCreating Prezto symlinks"
    ln -sf ~/.zprezto/runcoms/zlogin ~/.zlogin
    ln -sf ~/.zprezto/runcoms/zlogout ~/.zlogout
    ln -sf ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
    ln -sf ~/.zprezto/runcoms/zprofile ~/.zprofile
    ln -sf ~/.zprezto/runcoms/zshenv ~/.zshenv
    ln -sf ~/.zprezto/runcoms/zshrc ~/.zshrc

    # Patch Prezto runcoms
    echo -e "\nPatching Prezto runcoms"
    (cd ~/.zprezto/runcoms/ && curl -O https://raw.githubusercontent.com/sepidre/Ansible/main/UserRoot/zshrc) &> /dev/null
    (cd ~/.zprezto/runcoms/ && curl -O https://raw.githubusercontent.com/sepidre/Ansible/main/UserRoot/zpreztorc) &> /dev/null

    # Download zplug
    echo -e "\nDownloading zplug..."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

    echo -e "\nPrezto configuration complete (plugins will be installed on the first shell run)"

    #--------------------------------------------------
    # Theme (Powerlevel10k)
    #--------------------------------------------------
    echo -e "\nDownloading theme configuration"

    (cd ~/ && curl -o ".p10k.zsh" "https://raw.githubusercontent.com/sepidre/Ansible/main/UserRoot/.p10k.zsh") &> /dev/null
    echo -e "\nTheme configuration done"
    echo
    echo -e "Installing Meslo Nerd Font"

    # Select fonts folder based on the current platform
    if [[ "$OS" == "Linux" ]]; then
        FONTS_FOLDER_PATH=~/.fonts
    fi
    if [[ "$OS" == "Darwin" ]]; then
        FONTS_FOLDER_PATH=~/Library/Fonts
    fi

    # Make sure that the fonts directory exists
    mkdir -p ${FONTS_FOLDER_PATH}

    # Download fonts
    (curl -Lo "${FONTS_FOLDER_PATH}/MesloLGS NF Regular.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf") &> /dev/null
    (curl -Lo "${FONTS_FOLDER_PATH}/MesloLGS NF Bold.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf") &> /dev/null
    (curl -Lo "${FONTS_FOLDER_PATH}/MesloLGS NF Italic.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf") &> /dev/null
    (curl -Lo "${FONTS_FOLDER_PATH}/MesloLGS NF Bold Italic.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf") &> /dev/null

    # Refresh font cache if on Linux
    echo -e "Resetting Linux font cache"
    (fc-cache -f -v) &> /dev/null

    echo -e "\nInstalled the font"
    fi

    #--------------------------------------------------
    # Make Zsh the default shell
    #--------------------------------------------------
    echo -e "\nMaking Zsh the default shell for user '$(whoami)'..."
    PATH_TO_ZSH=$(command -v zsh)
    if [[ $PATH_TO_ZSH ]]; then
        sudo usermod --shell $PATH_TO_ZSH $(whoami)
        echo -e "Default shell for user '$(whoami)' is now set to '$PATH_TO_ZSH'."
    else
        echo "Could not make Zsh the default shell: Zsh could not be found. This means that installation has failed. Please check the logs above to find the issue."
        exit 1
    fi

    echo -e "\nPresto-Prezto configuration complete!\n"

    exit 0
else
    echo "This script is only supported on macOS and Linux."
    exit 0
fi
