#!/bin/bash

append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

source /etc/profile.d/cuda.sh

unset -f append_path
