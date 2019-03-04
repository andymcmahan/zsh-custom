#!/usr/bin/env bash
# Installation script for 10ft zsh theme

colorize() { CODE=$1; shift; echo -e '\033[0;'$CODE'm'$*'\033[0m'; }
bold() { echo -e "$(colorize 1 "$@")"; }
red() { echo -e "$(colorize '1;31' "$@")"; }
green() { echo -e "$(colorize 32 "$@")"; }
yellow() { echo -e "$(colorize 33 "$@")"; }
mkdir -p ~/.zsh

function preinstall(){
    dir="${1}"
    if [[ -d $dir ]]; then
        check_compete=false
        while [ $check_compete == 'false' ]
        do
            yellow "This will delete your old $dir install"
            printf 'continue? (y/n): '
            read response
            response=$(echo $response | awk '{print toupper($0)}')
            if [[ $response == 'Y' ]]; then
                yellow "Removing old $dir install"
                rm -rf "$dir"
                check_compete=true
            elif [[ $response == 'N' ]]; then
                red "Aborting, manually backup your $dir and rerun"
                exit 0
            else
                red "invalid input"
            fi
        done
    fi
}

bold "You must install Powerline fonts before continuing https://github.com/gabrielelana/awesome-terminal-fonts"
yellow "Follow these Instructions for OSX: https://github.com/gabrielelana/awesome-terminal-fonts/wiki/OS-X"
printf 'continue? (y/n): '
read response
response=$(echo $response | awk '{print toupper($0)}')
if [[ $response != 'Y' ]]; then
    exit 0
fi

bold "Installing oh-my-zsh"
preinstall ~/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

bold "Installing oh-my-zsh-custom"
preinstall ~/.oh-my-zsh-custom
git clone https://github.com/RallySoftware/oh-my-zsh-custom.git ~/.oh-my-zsh-custom

bold "Installing zaw"
preinstall ~/.zsh/zaw
git clone https://github.com/brandon-fryslie/zaw.git ~/.zsh/zaw

bold "Installing auto-suggestions"
preinstall ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

bold "Installing zsh-completions"
preinstall ~/.zsh/zsh-completions
git clone https://github.com/zsh-users/zsh-completions ~/.zsh/zsh-completions
cp -fr ~/.zsh/zsh-completions ~/.oh-my-zsh-custom/plugins/

bold "Installing zsh-syntax-highlighting"
preinstall ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/brandon-fryslie/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
cp -fr ~/.zsh/zsh-syntax-highlighting ~/.oh-my-zsh-custom/plugins/

bold "Installing rad-plugins"
preinstall ~/.zsh/rad-plugins
git clone https://github.com/brandon-fryslie/rad-plugins.git ~/.zsh/rad-plugins
cp -fr ~/.zsh/rad-plugins/zaw ~/.oh-my-zsh-custom/plugins/
cp -fr ~/.zsh/rad-plugins/shell-tools ~/.oh-my-zsh-custom/plugins/

bold "Installing Powerlevel9k"
preinstall ~/.zsh/powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.zsh/powerlevel9k
cp -fr ~/.zsh/powerlevel9k ~/.oh-my-zsh/themes/

if [[ -f ~/.zshrc ]]; then
    ts=$(date +%s)
    yellow "Backing up .zshrc to ~/.zshrc_$ts.backup"
    cp ~/.zshrc "${HOME}/.zshrc_${ts}.backup"
fi

bold "Installing ~/.zshrc"
cp -f zshrc_template ~/.zshrc

green "Done! Open a new tab"
green "Recommended iterm Font: Meslo Regular from Nerd or Powerline fonts"



