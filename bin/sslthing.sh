#!/bin/sh
## sslthing.sh 20040621 by blh [at] blh.se

## Location of openssl
ossl=`which openssl`

## Make a request (may be altered)
echo "GET / HTTP/1.0" > sslthing.tmp

###### END OF CONFIGURATION #####

if ! [ $1 ]; then
  echo syntax: $0 host:sslport [-v]
  exit
fi

if ! [ -e $ossl ]; then
  echo The path to openssl is wrong, please edit $0
  exit
fi

## Request available ciphers from openssl and test them
for ssl in -ssl2 -tls1
do
  echo Testing `echo $ssl | cut -c2- | tr "a-z" "A-Z"`...
  $ossl ciphers $ssl -v | while read line
  do
    cipher=`echo $line | awk '{print $1}'`
    bits=`echo $line | awk '{print $5}' | cut -f2 -d\( | cut -f1 -d\)`
    if [ $2 ]; then
      echo -n $cipher - $bits bits...
    fi

    if ($ossl s_client $ssl -cipher $cipher -connect $1 < sslthing.tmp 2>&1 | grep ^New > /dev/null); then
      if [ $2 ]; then
        echo OK
      else
        echo $cipher - $bits bits
      fi
    else
      if [ $2 ]; then
        echo Failed
      fi
    fi
  done | grep -v error
done

## Remove temporary file
rm -f sslthing.tmp
