
function copy-to-clipboard() {
cat $1 | xclip -i -selection clipboard
}
