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


echo "Deleting completion cache"
rm -rf ~/.zcompdump
rm -rf ~/.cache/prezto/zcompdump