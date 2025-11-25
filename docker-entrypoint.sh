#!/bin/bash
set -e

# Wait for MySQL to be available
MYSQL_HOST="${MYSQL_HOST:-mysql}"
MYSQL_PORT="${MYSQL_PORT:-3306}"

echo "Waiting for MySQL at $MYSQL_HOST:$MYSQL_PORT..."

# Wait up to 60 seconds for MySQL
for i in {1..60}; do
    if nc -z "$MYSQL_HOST" "$MYSQL_PORT" 2>/dev/null; then
        echo "MySQL is available!"
        break
    fi
    echo "Waiting for MySQL... ($i/60)"
    sleep 1
done

# Update the SQL config with the correct MySQL host
if [ -f /etc/freeradius/mods-config/sql/default ]; then
    sed -i "s/server = \"mysql\"/server = \"$MYSQL_HOST\"/" /etc/freeradius/mods-config/sql/default
    echo "Updated SQL config to use MySQL host: $MYSQL_HOST"
fi

# Start FreeRADIUS
exec /usr/sbin/freeradius -f
