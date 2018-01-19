#!/usr/bin/env bash

binder=''
sharedFolders='./shared-folders'

-init() {
    case "$OSTYPE" in
        darwin*) binder='bindfs -o local,allow_other,noappledouble,nobrowse' ;;
        linux*)  binder='mount --bind' ;;
    esac

    [ ! -f "${sharedFolders}" ] && \
        echo "[ERROR]: The file ${sharedFolders} doesn't exists" && \
        exit 1
}

+up() {
    while read -r line; do
        mkdir -p ${line#*:}
        ${binder} ${line%:*} ${line#*:}
    done < "${sharedFolders}"
}

+down() {
    while read -r line; do
        umount ${line#*:}
    done < "${sharedFolders}"
}

-init

case "$1" in
    up|down) +$1 ;;
    *) echo "Usage: $0 (up|down)" ;;
esac