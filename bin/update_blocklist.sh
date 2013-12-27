#!/bin/bash

curl -L "http://list.iblocklist.com/?list=bt_level{1,2,3}&fileformat=p2p&archiveformat=gz" -o ~/Library/Application\ Support/Transmission/blocklists/bt_level#1.gz

cd ~/Library/Application\ Support/Transmission/blocklists/
gzip -d *

