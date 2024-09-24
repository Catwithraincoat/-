export POSTGRES_USER=postgres1
export POSTGRES_ENCODING='WIN1251'
export POSTGRES_LOCALE='ru_RU.CP1251'
export POSTGRES_PORT=9653
export PGDATA="/usr/local/pgsql/qcd16"

mkdir   $PGDATA 
adduser $POSTGRES_USER
chown   $POSTGRES_USER $PGDATA

su      $POSTGRES_USER
