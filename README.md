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

# Otras configuraciones

## multiples credenciales git

```
# ~/.gitconfig
[includeIf "gitdir:/home/joselo/Documents/work/"]
	path = /home/joselo/Documents/work/.gitconfig-work
```

```
# ~/Documents/work/.gitconfig-work
# comando ssh que apunte a otra ssh key
[core]
  	SshCommand = "ssh -i ~/.ssh/id_ed25519_work"
[user]
	email = joselo@work.cl
	name = joselo
[safe]
	directory = /opt/flutter
[init]
	defaultBranch = main
```
