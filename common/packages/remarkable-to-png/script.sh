#!/usr/bin/env bash

set -e

show_help() {
  echo "remarkable 2 png"
  echo ""
  echo "usage:"
  echo "-i input directory for your remarkable backup"
  echo "-n name of the notebook"
  echo "-o output directory"
}
export AWS_PAGER="" # required to disable pagination https://stackoverflow.com/questions/65163245/how-to-disable-pagination-in-aws-cli

OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file=""
verbose=0

while getopts "h?i:n:b:p:r:o:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    i)  backup_dir=$OPTARG
        ;;
    n)  dirname=$OPTARG
        ;;
    o)  outdir=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))


[ "${1:-}" = "--" ] && shift


echo "Running sync with the following settings:"
echo ""
echo input: $backup_dir
echo notebook: $dirname
echo output dir: $outdir

if [ $OPTIND != 7 ]
then
  echo ""
  echo "All arguments are required"
  exit 1
fi


tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

for i in $backup_dir/*.metadata
do
  name=$(cat $i | jq -r ".visibleName")

  if [ "$name" = "$dirname" ]
  then
    notebook_found=$i
  fi
done


if [ $notebook_found ]
then
  name=$(cat $notebook_found | jq -r ".visibleName")
  notebook=$(basename "$notebook_found")
  path=$backup_dir/${notebook%.*}
  upload_dir=sync-$dirname

  mkdir -p "$outdir"/"$upload_dir"
  files=$(cat "$path".content | jq -r '.pages | join(" ")')

  i=0
  for file in $files
  do
    filename=$(printf "%03d" $i)-$file.png
    ((i=i+1))

    rM2svg -i "$path"/"$file".rm -o "$tmp_dir"/"$file".svg
    convert "$tmp_dir"/"$file".svg "$tmp_dir"/"$filename"
    cp "$tmp_dir"/"$filename" "$outdir"/"$upload_dir"/"$filename"
    echo Processed: "$filename"
  done
else
  echo "notebook not found"
fi
