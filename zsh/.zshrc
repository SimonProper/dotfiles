# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Paths
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

#Path to hombrew installs
export PATH=/opt/homebrew/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Volta
export VOLTA_HOME="$HOME/.volta"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# For lazygit
export XDG_CONFIG_HOME="$HOME/dotfiles"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z)

source $ZSH/oh-my-zsh.sh

# User configuration

# Alias
alias zshconfig="nvim ~/dotfiles/zsh/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="nvim ~/.config/nvim"
alias nvconf="nvim ~/.config/nvim"
alias pn="pnpm"
alias kittyconfig="nvim ~/dotfiles/kitty/kitty.conf"
alias nv="nvim"
alias gs="git switch"
alias vim='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/simonproper/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/simonproper/Documents/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/simonproper/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/simonproper/Documents/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/dotfiles/zsh//.p10k.zsh.
[[ ! -f ~/dotfiles/zsh//.p10k.zsh ]] || source ~/dotfiles/zsh//.p10k.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
