export POSTGRES_USER=postgres0
export POSTGRES_CONFIG_DIRECTORY="./config"
export POSTGRES_SUPER_USER_PASSWORD_FILE="$POSTGRES_CONFIG_DIRECTORY/postgres_su_password.txt"
export POSTGRES_PORT=9653
export PGDATA="$HOME/qcd16"

mkdir   $PGDATA                     

adduser $POSTGRES_USER              
chown   $POSTGRES_USER $PGDATA

su      $POSTGRES_USER
