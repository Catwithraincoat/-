export POSTGRES_USER=kitokato
export POSTGRES_ENCODING='WIN1251'
export POSTGRES_LOCALE='ru_RU.CP1251'
export POSTGRES_PORT=9653
export PGDATA="$HOME/qcd16"

mkdir   $PGDATA                     
chown   $POSTGRES_USER $PGDATA

su      $POSTGRES_USER
