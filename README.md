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

To manage the dotfiles create an alias to simplify commands:

```bash
git() {
  if [ "$PWD" = "$HOME" ]; then
    command git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
  else
    command git "$@"
  fi
}

```

## Components

### Tmux

#### Plugins

- **[Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)** - Package manager for managing Tmux plugins.

    It will be automatically cloned and initialized on first use (see `.tmux.conf` for details) to manage all Tmux plugins listed below.

    Key bindings:
    - Install plugins: `prefix + I`
    - Update plugins: `prefix + U`

- **[Tmux Sensible](https://github.com/tmux-plugins/tmux-sensible)** - Provides sensible tmux defaults for improved usability.

    The options can be found in the [tmux-sensible documentation](https://github.com/tmux-plugins/tmux-sensible?tab=readme-ov-file#options).

    Key bindings:
    - `prefix + R` - Reload the tmux configuration file
    - `Ctrl + [a + p]` - Switch to the previous window while holding Ctrl and keep pressing `a + p`
    - `Ctrl + [a + n]` - Switch to the next window while holding Ctrl and keep pressing `a + n`


- **[Tmux Resurrect](https://github.com/tmux-plugins/tmux-resurrect)** - Saves and restores complete Tmux sessions.

    Key bindings:
    - `prefix + Ctrl-s` - Save session
    - `prefix + Ctrl-r` - Restore session


## License

MIT
