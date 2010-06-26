#!/bin/bash
# copied and trimed from  http://snarfed.org/space/unixify

set -x

# check args
if [[ $# = "0" || $1 = "--help" ]]; then
  echo 'Usage: unixify.sh FILES...'
  exit 1
fi

for file in "$@"; do
  # clean filename
  newfile=`rename -v "y/ /_/;  \
                      s/[!?':\",\[\]()]//g; "'  \
                      s/&/and/g; y/A-Z/a-z/;  \
                      s/.../_/g;  \
                      s/_+/_/g;  \
                      s/_(.[^.]+$)/$1/;  \
                      s/.jpeg$/.jpg/' "$file"`

#  if [[ $newfile =~ ' renamed as ' ]]; then
#    file=${newfile/* renamed as /}
#  fi
#
#  if [[ $file =~ .(gif|jpg|png)$ ]]; then
#    # optimize image
#    convert $file $file
#  elif [[ $file =~ .doc$ ]]; then
#    # convert word doc to text
#    antiword $file > `basename $file .doc`.txt
#  fi

  if [[ `file -b $file` =~ text,.*with\ CRLF ]]; then
    # remove any carriage returns
    sed --in-place 's/\r//g' $file
  fi
done

