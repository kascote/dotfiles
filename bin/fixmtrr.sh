#!/bin/sh

echo "Extracing base address and memory size from lspci -v"

# extract the base address for the video memory
address=`lspci -v \
	| grep -A 7 VGA\
	| grep -F " prefetchable"\
	| awk 'BEGIN{OFS="";ORS=""}
	      {print $3
	      i = length($3)
	      while(i<8){
	      		print 0
	       		i++
	       }}'`

# we extract the memory size as a decimal number from lspci from the correct
# line, we then convert it to hexadecimal and fill it up with the correct
# number of zeroes

hsize=`lspci -v \
	| grep -A 7 VGA \
	| grep -F " prefetchable" \
	| awk '{print $6}' \
	| sed 's/[^0-9]//g' \
	| awk 'BEGIN {OFS = "";ORS=""}
	       { printf "%x" , $1
		 i = length($1)
		 while (i<8) {
		 	print 0
		 	i++
		 } }'`

echo $address
echo $hsize
echo

echo "Supplying corrected MTRR ranges to /proc/mtrr"
if ! grep -q $address /proc/mtrr; then
	echo "base=0x$address size=0x$hsize type=write-combining" >| /proc/mtrr && echo success
else
    echo doing nothing, MTRR range already set up
fi

cat /proc/mtrr

