#!/usr/bin/env zsh

cd /Users/jacobshu/dev/asn/client

deps=$(pnpm outdated --json)
echo $deps

# parse the json to a csv
names=$(echo $deps | jq -r 'keys[]')
parse=$(echo $deps | jq -r '.[] | [.current, .latest, .wanted] | @csv')
echo $names
echo $parse

exit
