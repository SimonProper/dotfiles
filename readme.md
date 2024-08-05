# Dotfiles

This is a collection of all the

## Setup

There are some initial steps that needs to be made for this to work.

1. clone the repo into your home directory `~/`
2. If not already pressent, create a `~/.zshrc` file.
3. Inside source the rc from the repo with the following
```shell
source "/Users/[username]/dotfiles/zsh/.zshrc"
```
4. After the sourcing you can add any secret keys you might have. e.g.
```shell
export GITHUB_NPM_TOKEN="some magic github token"
```
5. If using Kitty, we need to link the default kitty directory to the one provided in this repo. First, make sure that the directory `~/.config` does not cotain a /kitty directory. Then use the command `ln -s ~/dotfiles/kitty/ ~/.config/kitty`
