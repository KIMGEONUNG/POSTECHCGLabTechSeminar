#!/bin/bash
ZSH=$HOME/.oh-my-zsh                                # Path to your oh-my-zsh configuration.
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom                  # Path to your oh-my-zsh configuration.
ZSH_CUSTOM_THEMES=$HOME/.oh-my-zsh/custom/themes    # Path to your oh-my-zsh configuration.
ZSH_CUSTOM_PLUGINS=$HOME/.oh-my-zsh/custom/plugins  # Path to your oh-my-zsh configuration.

########################
# THEME
########################
# ZSH_THEME="robbyrussell"              # Default theme
# ZSH_THEME="spaceship-prompt/spaceship"
ZSH_THEME=random
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# agnoster needs powerline font
# sudo apt install fonts-powerline​

########################
# PLUGINS
########################
if [ ! -d $ZSH_CUSTOM_PLUGINS/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM_PLUGINS/zsh-autosuggestions
fi
if [ ! -d $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting
fi
if [ ! -d $ZSH_CUSTOM_THEMES/spaceship-prompt ]; then
    git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM_THEMES/spaceship-prompt
fi
if [ ! -d $ZSH_CUSTOM_THEMES/agnoster-zsh-theme ]; then
    git clone https://github.com/agnoster/agnoster-zsh-theme.git $ZSH_CUSTOM_THEMES/agnoster-zsh-theme
fi

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
)

########################
# source oh my zsh
########################
source $ZSH/oh-my-zsh.sh

########################
# Agnoster THEME SETTING (this should be after source oh-my-zsh)
########################
# source $HOME/.zsh/set_agnoster.zsh

########################
# KEY BINDINGS
########################
bindkey '^l' autosuggest-accept
bindkey '^h' autosuggest-clear
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey '^[[3~' delete-char
bindkey '^H' backward-delete-char

########################
# Alias
########################
alias tmux="tmux -2 -u"
# tmux -2 : force tmux to assume the terminal supports 256 colours
# tmux -u : tmux attempts to guess if the terminal is likely to support UTF-8 by checking
#           the first of the LC_ALL, LC_CTYPE and LANG environment variables to be set for
#           the string "UTF-8".  This is not always correct: the -u flag explicitly
#           informs tmux that UTF-8 is supported.
#           If the server is started from a client passed -u or where UTF-8 is detected,
#           the utf8 and status-utf8 options are enabled in the global window and session
#           options respectively.

if [[ -n "$TMUX" ]]; then
    bindkey "^[[1~" beginning-of-line
    bindkey '^[[4~' end-of-line
fi

# syntax hihlighing plugin (should be at the end of zshrc file)
source $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#######################
# My settings
#######################
alias "pip=pip3"
alias "python=python3"
cd(){builtin cd "$@" && pwd && ls;}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME:$PATH"
export PATH="/home/kkang/bin:$PATH"
source kk
