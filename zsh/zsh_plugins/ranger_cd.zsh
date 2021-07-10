function ranger-cd {
tempfile="$(mktemp -t tmp.XXXXXX)"
/usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

bindkey -s '^O' 'ranger-cd\n'
