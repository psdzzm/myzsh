#!/bin/zsh

set -e

SCRIPT_DIR="${0:A:h}"
echo "SCRIPT_DIR: $SCRIPT_DIR"

echo "Updating Docker completion"
docker completion zsh >! "${SCRIPT_DIR}/src/_docker"


echo "Updating conda completion"
wget https://raw.githubusercontent.com/conda-incubator/conda-zsh-completion/master/_conda -qO "${SCRIPT_DIR}/src/_conda"


echo "Updating rustup and cargo completions"
rustup completions zsh >! "${SCRIPT_DIR}/src/_rustup"
rustup completions zsh cargo >! "${SCRIPT_DIR}/src/_cargo"

echo "Updating procs completion"
procs --gen-completion-out zsh >! "${SCRIPT_DIR}/src/_procs"

echo "Updating restic completion"
resticprofile generate --zsh-completion >! "${SCRIPT_DIR}/src/_resticprofile"

# echo "Updating zellij completion"
# zellij setup --generate-completions zsh >! "${SCRIPT_DIR}/src/_zellij"

echo "Updating rustic completion"
rustic completions zsh >! "${SCRIPT_DIR}/src/_rustic"

echo "Deleting completion cache"
rm -rf ~/.zcompdump
rm -rf ~/.cache/prezto/zcompdump

autoload -Uz compinit
mkdir -p ~/.cache/prezto
compinit -C -d ~/.cache/prezto/zcompdump
zcompile ~/.cache/prezto/zcompdump