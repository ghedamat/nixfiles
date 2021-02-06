#!/usr/bin/env bash

# crappy script to extract mood notes from exist and push them into my daily notes
# this could have been better done with another lang probably but wanted to hack something quick

set -e

show_help() {
  echo "exist-to-obsidian"
  echo ""
  echo "usage:"
  echo "-u username"
  echo "-p password"
  echo "-d start iso-date"
  echo "-e end iso-date (optional)"
  echo "-o notes directory"
}

OPTIND=1         # Reset in case getopts has been used previously in the shell.

while getopts "h?u:p:d:e:o:" opt; do
  case "$opt" in
    h|\?)
      show_help
      exit 0
      ;;
    u)  username=$OPTARG
      ;;
    p)  password=$OPTARG
      ;;
    d)  start_date=$OPTARG
      ;;
    e)  end_date=$OPTARG
      ;;
    o)  notes_dir=$OPTARG
      ;;
  esac
done

shift $((OPTIND-1))


[ "${1:-}" = "--" ] && shift


echo "updating daily note with following settings"
echo start date: "$start_date"
echo end_date: "$end_date"
echo notes dir: "$notes_dir"
echo ""

if [ $OPTIND -lt 9 ]
then
  echo ""
  echo "arguments required:"

  show_help
  exit 1
fi

function fetch_field() {
  curl -s "$1" -H "Authorization: Token $token" | jq -r ".results | map(select(.date==\"$2\"))[0].value"
}

# note to self
# maybe one refactor this to issue only 3 requests and manipulate the data out of the json blob instead
# also note that this breaks if the date we are looking for is not of the first page of results
function update_day() {
  note_date=$1
  dest_file=$(find "$notes_dir" -name "$note_date*" | grep _Daily)
  echo update_day "$note_date" "$dest_file"

  { \
    echo "# Exist tracking:"; \
    echo -n "### exist_mood_level: "; \
    fetch_field "https://exist.io/api/1/users/$username/attributes/mood/" "$note_date"; \
    echo "### exists_mood_note: "; \
    fetch_field "https://exist.io/api/1/users/$username/attributes/mood_note/" "$note_date"; \
    echo ""; \
    echo "### exist_tags:"; \
    fetch_field "https://exist.io/api/1/users/$username/attributes/custom/" "$note_date" | \
    sed -e 's/,//g' | \
    sed -e 's/^/#exist_/g' | \
    sed -e 's/ / #exist_/g'; \

    echo ""; \
    echo "";
  } | cat - "$dest_file" > temp && mv temp "$dest_file"
}


token=$(curl -s https://exist.io/api/1/auth/simple-token/ -d username="$username" -d password="$password" | jq -r '.[]' )

if [ -z "$end_date" ]
then
  end_date=$start_date
fi

while ! [[ $start_date > $end_date ]]; do
  update_day "$start_date"
  start_date=$(date -d "$start_date + 1 day" +%F)
done
