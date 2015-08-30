#!/bin/bash
# Simply command line translator based on google translate engine
# stranslate v. 2
# by Irek "Monsoft" Pelech
# http://www.adminondemand.co.uk
# (c) 2012-2014 Ascot,UK

# Change log:
# 1. Changed urls to SSL based (google stop used unencrypted connections)
# 2. Add function of translating text files
# 3. Better "Usage" description
# 4. Change name from translate to stranslate to prevent clashing with other software

function banner() {
  echo -e "\nsTranslate v.2 by Irek \"Monsoft\" Pelech (c) 2012-2014 www.adminondemand.co.uk"
  #echo -e "-------------------------\n"
}



function connection_check() {
# Check if curl is installed
curl -V >/dev/null 2>&1|| { echo "I require curl but it's not installed. Aborting." >&2; exit 1;}

# Check internet connectivity
curl -v www.google.co.uk 2>&1|grep -m1 "HTTP/1.1" >/dev/null 2>&1|| { echo "I require internet connection. Aborting." >&2; exit 1;}
}

# Main
if [ $# -lt 3 ]
  then

    connection_check
    banner
    echo -e "\nAvailable languages:"
    echo -e "--------------------\n"
    curl -s --user-agent "Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.34 (KHTML, like Gecko) QupZilla/1.3.1 Safari/534.34" "https://translate.google.com/m?&mui=sl"|grep -Eo 'sl=[a-z]{2}">[^>]*<'|sed 's/sl=//g;s/">/ -> /g;s/<//g'|tr "\n" ","|awk -F, '{ for ( i=1; i<=NF;i=i+2) print $i "\t\t\t"$(i+1)}'
                echo -e "\nUsage:\n\t`basename $0` From To Sentence/Word"
                echo -e "\t`basename $0` From To -f filename_to_translate filename_to_save"
                echo -e "\t`basename $0` From To -f filename_to_translate"

        echo -e "\nExamples:\n\t`basename $0` en pl how \t\t\t\t\tTranslate word how from English to Polish"
        echo -e "\t`basename $0` en es \"How they do it\"\t\t\tTranslate Sentence from English to Spanish"
        echo -e "\t`basename $0` en ja -f file_to_translate file_to_save\tTranslate file from English to Japanese"
        echo -e "\t`basename $0` en de -f file_to_translate\t\t\tTranslate file from English to German on the screen"
        exit 1
fi

if [ "$1" = "$2" ]
  then
    banner
    echo -e "->Text already in this same language. Nothing to translate !!!\n"
    exit 1
fi

FROM=$1
TO=$2

if [ "$3" = "-f" ]
  then
      if [ -f $4 ]
        then
          INPUT_F=$4
          OUTPUT_F=$5

          banner
          echo -e "->Translating file `basename ${INPUT_F}` from language ${FROM} -> ${TO}\n"
          if [ "$5" = "" ]
            then
              curl -s -F file=@${INPUT_F} --user-agent "Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.34 (KHTML, like Gecko) QupZilla/1afari/534.34" "http://translate.googleusercontent.com/translate_f?hl=en&sl=${FROM}&tl=${TO}&ie=UTF-8&prev=_m"| sed -e 's/^.*<pre>//' -e 's!</pre>.*!!'|grep -v "^<meta"|sed -e 's/&quot;/\"/g' -e "s/&#39/\'/g"
            else
              curl -s -F file=@${INPUT_F} --user-agent "Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.34 (KHTML, like Gecko) QupZilla/1afari/534.34" "http://translate.googleusercontent.com/translate_f?hl=en&sl=${FROM}&tl=${TO}&ie=UTF-8&prev=_m"| sed -e 's/^.*<pre>//' -e 's!</pre>.*!!'|grep -v "^<meta"|sed -e 's/&quot;/\"/g' -e "s/&#39/\'/g" > $OUTPUT_F
              echo -e "\nTranslated file saved to ${OUTPUT_F}."
          fi
        else
          echo "File $4 don't exist"
          exit 1
      fi
  else
    SENTENCE=`echo $3|tr " " "+"`
    banner
    echo -e "->Translating from language ${FROM} -> ${TO}:\n"
    curl -s --user-agent "Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.34 (KHTML, like Gecko) QupZilla/1.3.1 Safari/534.34" "https://translate.google.com/m?hl=en&sl=${FROM}&tl=${TO}&ie=UTF-8&prev=_m&q=${SENTENCE}"|sed -n 's/.*class="t0">//;s/<.*$//p'
    echo -e "\n"
  fi
