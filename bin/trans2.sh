#!/usr/bin/env bash

text="$(xsel -o)"
text=$(echo "$text" | sed "s/[\"'<>]//g")
translate="$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=es&dt=t&q=${text}" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2, $6}')"
echo -e "Original text:" "$text"'\n' > /tmp/notitrans
echo "Translation:" "$translate" >> /tmp/notitrans
zenity --text-info --title="Translation" --filename=/tmp/notitrans
