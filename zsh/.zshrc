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

# pnpm
export PNPM_HOME="/Users/simon.proper/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

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
alias nv='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

 lazynvm() {
   unset -f nvm node npm
   export NVM_DIR=~/.nvm
   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
 }

 export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

 nvm() {
   lazynvm 
   nvm $@
 }

 node() {
   lazynvm
   node $@
 }

 npm() {
   lazynvm
   npm $@
 }

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/simonproper/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/simonproper/Documents/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/simonproper/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/simonproper/Documents/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/dotfiles/zsh//.p10k.zsh.
[[ ! -f ~/dotfiles/zsh//.p10k.zsh ]] || source ~/dotfiles/zsh//.p10k.zsh
