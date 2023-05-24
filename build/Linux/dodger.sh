#!/bin/sh
echo -ne '\033c\033]0;First 2D Game\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/dodger.x86_64" "$@"
