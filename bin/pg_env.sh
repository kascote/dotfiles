#!/bin/sh
# The script sets environment variables helpful for PostgreSQL

export PATH=/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH
export PGDATA=/Users/nelson/Library/Application\ Support/Postgres/var-9.3
export PGDATABASE=nelson
export PGUSER=nelson
export PGPORT=5432
#export PGLOCALEDIR=/Library/PostgreSQL/9.3/share/locale
export MANPATH=$MANPATH:/Applications/Postgres.app/Contents/Versions/9.3/share/man

