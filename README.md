# Dotfiles

My personal configuration files for various development tools and applications.

## Contents

This repository contains configuration files for:

- Vim/Neovim

## Installation


I manage these dotfiles using a bare Git repository. While the commands are lengthy, you can simplify them with an alias. The following script sets up the initial installation by cloning an existing repository:


```bash
#!/usr/bin/env bash

# Clone the dotfiles repository as a bare repository
git clone --bare git@github.com:spinnerok/dotfiles.git $HOME/.dotfiles

# Create a function to manage dotfiles using git
function dotfiles {
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# Create a backup directory for existing dotfiles
mkdir -p .dotfiles-backup

# Attempt to checkout dotfiles from the repository
dotfiles checkout
if [ $? = 0 ]; then
     echo "Checked out dotfiles from git@github.com:spinnerok/dotfiles.git"
else
     # If checkout fails, backup conflicting files and retry
     echo "Moving existing dotfiles to ~/.dotfiles-backup"
     dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
     dotfiles checkout
fi

# Hide untracked files from git status output
dotfiles config status.showUntrackedFiles no
```

## License

MIT
