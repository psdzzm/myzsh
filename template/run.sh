#!/bin/bash

set -e

zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
echo "SCRIPT_DIR: $SCRIPT_DIR"

mkdir -p ~/.config

# link clangd configuration
mkdir -p ~/.config/clangd
ln -sf $SCRIPT_DIR/clangd.yaml ~/.config/clangd/config.yaml

# link gpg configuration
mkdir -p ~/.gnupg
ln -sf $SCRIPT_DIR/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# link firejail configuration
ln -sf $SCRIPT_DIR/firejail ~/.config/firejail

# link vscode configuration
ln -sf $SCRIPT_DIR/code-flags.conf ~/.config/code-flags.conf

# link kde plasma session environment variables
mkdir -p ~/.config/plasma-workspace/env
ln -sf $SCRIPT_DIR/plasma-session-env.sh ~/.config/plasma-workspace/env/plasma-session-env.sh