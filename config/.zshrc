cat ~/.cache/wal/sequences
nitch
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The following lines were added by compinstall
zstyle :compinstall filename '/home/maps/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# Created by `pipx` on 2025-06-16 16:11:10
export PATH="$PATH:/home/maps/.local/bin"
alias v="nvim"
alias cma= "cmatrix -mxbosa"
alias update="sudo pacman -Syu --noconfirm"
alias d="sudo pacman -S"
alias dd="sudo pacman -Rc"
alias ls="ls --color=always" 
alias ff="nitch"
alias ch="chmod +x"
alias tm="bash ~/.local/bin/timer.sh"
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

