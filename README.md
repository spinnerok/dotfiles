# Dotfiles

My personal configuration files for various development tools and applications.

## Contents

This repository contains configuration files for:

- Vim/Neovim

## Installation

I manage these dotfiles using a bare Git repository. The following script sets up the initial installation by cloning an existing repository:

```bash
#!/usr/bin/env bash

# Clone the dotfiles repository as a bare repository
git clone --bare git@github.com:spinnerok/dotfiles.git $HOME/.dotfiles

# Create a function to manage dotfiles using git
function dotfiles {
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
}

# Attempt to checkout dotfiles from the repository
if dotfiles checkout >/dev/null 2>&1; then
    echo "Checked out dotfiles from git@github.com:spinnerok/dotfiles.git"
else
    # If checkout fails, backup conflicting files and retry
    echo "Moving existing dotfiles to ~/.dotfiles-backup"

    # Create a backup directory for existing dotfiles
    mkdir -p ~/.dotfiles-backup

    dotfiles checkout 2>&1 | awk '
        /would be overwritten by checkout:/ { capture = 1; next }
        /Please move or remove them before you switch branches\./ { capture = 0 }
        capture && /^[[:space:]]/ {
            sub(/^[[:space:]]+/, "", $0)
            print $0
        }
    ' | while IFS= read -r file; do
        echo "Backing up $file to ~/.dotfiles-backup/$file"
        mkdir -p "$HOME/.dotfiles-backup/$(dirname "$file")"
        mv "$HOME/$file" "$HOME/.dotfiles-backup/$file"
    done
    dotfiles checkout
fi

# Hide untracked files from git status output
dotfiles config status.showUntrackedFiles no
```

You can create an alias to simplify commands:

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

## License

MIT
