#!/bin/bash

CREATE_USER="CREATE USER '${1}'@'localhost' IDENTIFIED BY '${2}';"
GRANT="GRANT ALL PRIVILEGES ON ${3}.* to '${1}'@'localhost';"
SHOW="SHOW GRANTS FOR '${1}'@'localhost';"

mysql -uroot -p << EOF

${CREATE_USER}
${GRANT}
${SHOW}

EOF

