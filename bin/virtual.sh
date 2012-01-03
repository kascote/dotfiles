
TS[1]="172.16.45.4"
TS[2]="172.16.45.3"
TS[3]="172.16.45.5"
TS[4]="172.16.45.6"

echo "server ${TS[$1]}"
rdesktop -u contenidos -p ESXdesa01 -a 16 -g 1152x648 ${TS[$1]}


