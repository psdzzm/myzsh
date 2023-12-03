#!/bin/zsh

ssh_key_list=()

for file in ~/.ssh/*.pub; do
    ssh_key_list+=(~/.ssh/$(basename -s .pub $file))
done

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
ssh-add ${ssh_key_list[@]}
