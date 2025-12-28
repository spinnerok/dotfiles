# Dotfiles

My personal configuration files for various development tools and applications.

## Installation

### Using chezmoi

My preferred way to manage these dotfiles is using [chezmoi](https://www.chezmoi.io/):

```bash
# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# Initialize with this repository
chezmoi init https://github.com/yourusername/dotfiles.git

# Preview changes
chezmoi diff

# Apply the dotfiles
chezmoi apply -v
```

To update later:

```bash
chezmoi update -v
```

### Manual Installation

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
# Symlink or copy files as needed
```

## Usage

Review the configurations and adapt them to your needs before applying.

## License

MIT
