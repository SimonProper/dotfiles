# Dotfiles

This is a collection of all the

## Setup

There are some initial steps that needs to be made for this to work.

1. clone the repo into your home directory `~/`
2. If not alreaddy pressent, create a `~/.zshenv` file.
3. Iside set the variable `ZDOTDIR=$HOME/dotfiles/zsh/`, this provides the path to the zsh config inside the dotfiles folder
4. If using Kitty, we need to link the default kitty directory to the one provided in this repo. First, make sure that the directory `~/.config` does not cotain a /kitty directory. Then use the command `ln -s ~/dotfiles/kitty/ ~/.config/kitty/`
