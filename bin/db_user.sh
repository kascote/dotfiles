#!/bin/sh

CREATE_USER="CREATE USER '$1'@'localhost' IDENTIFIED BY '$2';"
GRANT="GRANT ALL ON $3.* to '$1'@'localhost' "

CMD="$CREATE_USER ; $GRAT"

echo $CMD | mysql -uroot -p

