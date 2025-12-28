#!/bin/bash

# Exit on error (-e), unset variable (-u), and failed pipeline command (-o pipefail)
set -euo pipefail

# Install required base tools depending on the operating system
echo "Installing ZSH and required packages..."

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Check if brew is installed on macOS and if not install it
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # macOS path: use Homebrew
    if command -v brew >/dev/null 2>&1; then
        brew install zsh git curl
    else
        echo "Homebrew not found. Please install Homebrew first: https://brew.sh"
        exit 1
    fi
elif [[ -f /etc/os-release ]]; then
    # Linux path: detect distro from /etc/os-release
    . /etc/os-release
    case "$ID" in
        ubuntu|debian|linuxmint|pop)
            # Debian/Ubuntu family
            sudo apt update
            sudo apt install -y zsh git curl
            ;;
        fedora|rhel|centos|rocky|almalinux)
            # Fedora/RHEL family
            sudo dnf install -y zsh git curl
            ;;
        *)
            echo "Unsupported Linux distribution: $ID"
            echo "Please install zsh, git, and curl manually."
            exit 1
            ;;
    esac
else
    echo "Unsupported operating system."
    echo "Please install zsh, git, and curl manually."
    exit 1
fi

# Install Oh My ZSH
echo "Installing Oh My ZSH..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	echo "oh-my-zsh already exists, skipping install."
fi

# Install plugins
echo "Installing ZSH plugins..."

# Default plugin directory used by Oh My Zsh
# ZSH_CUSTOM=${ZSH_CUSTOM:.oh-my-zsh/custom}
mkdir -p ${ZSH_CUSTOM}/plugins 

cd ${ZSH_CUSTOM}/plugins 

# Clone plugin only when missing
if [ ! -d "zsh-completions" ]; then
	git clone https://github.com/zsh-users/zsh-completions.git zsh-completions
else
	echo "zsh-completions already exists, skipping clone."
fi

# Clone plugin only when missing
if [ ! -d "zsh-autosuggestions" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions.git zsh-autosuggestions
else
	echo "zsh-autosuggestions already exists, skipping clone."
fi

# Clone plugin only when missing
if [ ! -d "zsh-syntax-highlighting" ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting
else
	echo "zsh-syntax-highlighting already exists, skipping clone."
fi

# Clone plugin only when missing
if [ ! -d "fast-syntax-highlighting" ]; then
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git fast-syntax-highlighting
else
	echo "fast-syntax-highlighting already exists, skipping clone."
fi

# Clone plugin only when missing (shallow clone for faster install)
if [ ! -d "zsh-autocomplete" ]; then
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git zsh-autocomplete
else
	echo "zsh-autocomplete already exists, skipping clone."
fi

# Change .zshrc file
# echo "Configuring .zshrc..."
# sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' ~/.zshrc

# switch to zsh as default shell
echo "Checking default shell..."
zsh_path="$(command -v zsh)"

if [[ "$OSTYPE" == "darwin"* ]]; then
	# macOS: read login shell from Directory Service
	current_shell="$(dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}')"
else
	# Linux: read login shell from passwd database
	current_shell="$(getent passwd "$USER" | cut -d: -f7)"
fi

# Fallback when shell lookup returns empty
if [ -z "${current_shell:-}" ]; then
	current_shell="$SHELL"
fi

if [ "$current_shell" != "$zsh_path" ]; then
	echo "Changing default shell to ZSH..."
	chsh -s "$zsh_path" "$USER"
else
	echo "ZSH is already the default shell, skipping change."
fi

echo "Installation completed! Please restart your terminal or run 'source ~/.zshrc' to apply changes."
