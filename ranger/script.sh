echo "name: "
read -r name
zip ${name}.zip -r "$@"
