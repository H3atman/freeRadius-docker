#!/bin/bash
set -e

# Wait for MySQL to be available
MYSQL_HOST="${MYSQL_HOST:-mysql}"
MYSQL_PORT="${MYSQL_PORT:-3306}"

echo "Waiting for MySQL at $MYSQL_HOST:$MYSQL_PORT..."

# Wait up to 120 seconds for MySQL
MAX_TRIES=120
for i in $(seq 1 $MAX_TRIES); do
    if nc -z "$MYSQL_HOST" "$MYSQL_PORT" 2>/dev/null; then
        echo "MySQL is available!"
        break
    fi
    if [ "$i" -eq "$MAX_TRIES" ]; then
        echo "ERROR: MySQL not available after $MAX_TRIES seconds, starting anyway..."
    fi
    echo "Waiting for MySQL... ($i/$MAX_TRIES)"
    sleep 1
done

# Additional wait for MySQL to be fully ready (not just accepting connections)
echo "Waiting additional 5 seconds for MySQL to fully initialize..."
sleep 5

# Update the SQL config with the correct MySQL host (handle any previous value)
SQL_CONFIG="/etc/freeradius/mods-config/sql/default"
if [ -f "$SQL_CONFIG" ]; then
    # Replace server = "anything" with server = "$MYSQL_HOST"
    sed -i "s/server = \"[^\"]*\"/server = \"$MYSQL_HOST\"/" "$SQL_CONFIG"
    echo "Updated SQL config to use MySQL host: $MYSQL_HOST"
fi

echo "Starting FreeRADIUS..."
# Start FreeRADIUS in foreground with full debug output
exec /usr/sbin/freeradius -X -f
