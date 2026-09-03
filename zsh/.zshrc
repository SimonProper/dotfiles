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

# bun completions
[ -s "/Users/simon/.bun/_bun" ] && source "/Users/simon/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

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
alias rawclaude="command claude"
alias rawopencode="command opencode"

# herdr hardcodes TERM=xterm-256color (herdr#554), which has no Setulc, so
# nvim can't color diagnostic underlines. Restore Ghostty's own entry.
if [[ -n "$HERDR_ENV" && "$TERM" == "xterm-256color" && "$TERM_PROGRAM" == "ghostty" ]]; then
  export TERM=xterm-ghostty
fi

# nono sandbox wrappers.
# Standing grants live in the profiles at $XDG_CONFIG_HOME/nono/profiles/
# (claude-local, opencode-local). These wrappers only add one-off grants:
# leading nono flags are hoisted in front of `--`, the rest goes to the app.
#   claude --allow ~/other-repo --resume       # one-off directory
#   claude --extends rust-dev                  # layer a toolchain profile
# Anything needed twice belongs in the profile, not here. On a denial run
# `nono why --path <p> --op read`, then promote the drafted profile with
# `nono profile promote <name>`.
# Long forms only. nono's short -a/-r/-w collide with the app's own
# flags -- claude's -r is --resume and -w is --worktree -- so hoisting
# them would swallow the app's flag and misroute its argument.
# Use `--` to end grant parsing explicitly if an app flag would collide.
_nono_split() {
  _nono_grants=()
  while (( $# )); do
    case "$1" in
      --) shift; break ;;
      --allow|--read|--write|--allow-file|--read-file|--write-file|\
      --bypass-protection|--suppress-save-prompt|--workdir|--extends|\
      --allow-domain|--deny-domain|--network-profile)
        (( $# >= 2 )) || { print -u2 "nono wrapper: $1 needs an argument"; return 1 }
        _nono_grants+=("$1" "$2"); shift 2 ;;
      --allow=*|--read=*|--write=*|--allow-file=*|--read-file=*|--write-file=*|\
      --bypass-protection=*|--suppress-save-prompt=*|--workdir=*|--extends=*|\
      --allow-domain=*|--deny-domain=*|--network-profile=*)
        _nono_grants+=("$1"); shift ;;
      --allow-cwd|--block-net)
        _nono_grants+=("$1"); shift ;;
      *) break ;;
    esac
  done
  _nono_args=("$@")
}

claude() {
  local -a _nono_grants _nono_args
  _nono_split "$@" || return 1
  HERDR_AGENT=claude command nono run --allow-cwd --profile claude-local \
    "${_nono_grants[@]}" -- claude "${_nono_args[@]}"
}

opencode() {
  local -a _nono_grants _nono_args
  _nono_split "$@" || return 1
  HERDR_AGENT=opencode command nono run --allow-cwd --profile opencode-local \
    "${_nono_grants[@]}" -- opencode "${_nono_args[@]}"
}

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
