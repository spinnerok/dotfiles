#!/bin/bash

set -euo pipefail

# Function for logging
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Handle dotfiles with chezmoi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log "Applying dotfiles from $SCRIPT_DIR"
chezmoi init --apply --source "$SCRIPT_DIR"

log "Setup completed successfully"

