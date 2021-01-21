#!/usr/bin/env bash

set -e

show_help() {
  echo "remarkable s3 sync"
  echo ""
  echo "usage:"
  echo "-i input directory for your remarkable backup"
  echo "-n name of the notebook"
  echo "-b s3 bucket"
  echo "-p aws_profile"
  echo "-r aws_region"
  echo "-o output file"
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
    b)  bucket=$OPTARG
        ;;
    p)  aws_profile=$OPTARG
        ;;
    r)  aws_region=$OPTARG
        ;;
    o)  outfile=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))


[ "${1:-}" = "--" ] && shift


echo "Running sync with the following settings:"
echo ""
echo input: $backup_dir
echo notebook: $dirname
echo s3 bucket: $bucket
echo aws_profile: $aws_profile
echo aws_region: $aws_region
echo output file: $outfile

if [ $OPTIND != 13 ]
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
  notebook=$(basename $notebook_found)
  path=$backup_dir/${notebook%.*}

  echo -n "" > $outfile
  files=$(cat $path.content | jq -r '.pages | join(" ")')

  for i in $files
  do
    filename=$i.png
    upload_dir=sync-$dirname

    rM2svg -i $path/$i.rm -o $tmp_dir/$i.svg
    convert $tmp_dir/$i.svg $tmp_dir/$filename
    aws s3 cp $tmp_dir/$i.png s3://$bucket/$upload_dir/$filename --profile $aws_profile
    aws s3api put-object-acl --bucket $bucket --profile $aws_profile --key $upload_dir/$filename --acl public-read
    echo https://$bucket.s3.$aws_region.amazonaws.com/$upload_dir/$filename >> $outfile
  done
else
  echo "notebook not found"
fi
