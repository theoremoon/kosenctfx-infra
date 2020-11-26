#!/bin/bash

files="ssh.key aws.yml"
for f in $files; do
    if [ "$1" = "decrypt" ]; then
        option=decrypt
        from="${f}.vault"
        to="${f}"
    else
        option=encrypt
        from="${f}"
        to="${f}.vault"
    fi

    ansible-vault "$option" "$from" --vault-password-file ./vault-key.sh --output "${to}" && rm "${from}"
done

