#!/usr/bin/env zsh

cd /Users/jacobshu/dev/asn/client

typeofvar () {
    local type_signature=$(declare -p "$1" 2>/dev/null)

    if [[ "$type_signature" =~ "declare --" ]]; then
        printf "string\n"
    elif [[ "$type_signature" =~ "declare -a" ]]; then
        printf "array\n"
    elif [[ "$type_signature" =~ "declare -A" ]]; then
        printf "map\n"
    else
        printf "none\n"
    fi
}

pnpm=$(pnpm outdated --json)

# parse the json to a csv
n=$(echo $pnpm | jq -r 'keys[]')
p=$(echo $pnpm | jq -r '.[] | [.current, .latest, .wanted] | @csv')

names=($n)
deps=($p)
length=${#names[@]}
rows=()

for (( i=0; i<length; i++)); do
    name=${names[$i]}
    dep=${deps[$i]}
    str=$name,$dep
    rows+=($str)
done

csv=$(printf "%s" "${rows[@]}")
echo $csv | cut -d ',' -f 1
