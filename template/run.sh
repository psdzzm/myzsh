#!/bin/bash

set -e

zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
echo "SCRIPT_DIR: $SCRIPT_DIR"

# link clangd configuration
mkdir -p ~/.config/clangd
ln -sf $SCRIPT_DIR/clangd.yaml ~/.config/clangd/config.yaml

ln -sf $SCRIPT_DIR/java.opts ~/java.opts