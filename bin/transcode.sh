vcodec="dummy"
acodec="mp3"
bitrate="1024"
arate="196"
ext="mp3"
mux="raw"
vlc="/Applications/VLC.app/Contents/MacOS/VLC"
dst="/home/user/"

for a in "$@"; do
  echo "$a"
  $vlc -I dummy "./$a" --sout "#transcode{vcodec=$vcodec,acodec=$acodec,ab=$arate}:standard{mux=$mux,dst=\"./$a.$ext\",access=file}" vlc://quit
done

