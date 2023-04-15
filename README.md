# dotfiles
dotfiles

Installing:
1. echo ".cfg" >> .gitignore
2. git clone --bare <remote-git-repo-url> $HOME/.cfg
3. alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
4. config config --local status.showUntrackedFiles no
5. config checkoutNow


## dependencies:

[tmux plugin manager](https://github.com/tmux-plugins/tpm)
