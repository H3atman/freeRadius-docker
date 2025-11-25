FROM freeradius/freeradius-server:latest

# Install netcat for connection checking
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

# Copy configuration files INTO the image
COPY raddb/clients.conf /etc/freeradius/clients.conf
COPY raddb/mods-config/files/authorize /etc/freeradius/mods-config/files/authorize
COPY raddb/radiusd.conf.d/logging.conf /etc/freeradius/radiusd.conf.d/logging.conf
COPY raddb/mods-config/sql/default /etc/freeradius/mods-config/sql/default

# Enable SQL module with ordered symlinks (00-sql loads before 01-sqlcounter)
# This ensures ${modules.sql.dialect} is defined before sqlcounter parses it
RUN rm -f /etc/freeradius/mods-enabled/sql /etc/freeradius/mods-enabled/sqlcounter && \
    ln -sf /etc/freeradius/mods-config/sql/default /etc/freeradius/mods-enabled/00-sql && \
    ln -sf /etc/freeradius/mods-available/sqlcounter /etc/freeradius/mods-enabled/01-sqlcounter

# Set proper permissions
RUN chmod 644 /etc/freeradius/clients.conf && \
    chmod 644 /etc/freeradius/mods-config/files/authorize && \
    chmod 644 /etc/freeradius/radiusd.conf.d/logging.conf && \
    chmod 644 /etc/freeradius/mods-config/sql/default

# Copy and set up entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Expose RADIUS ports
EXPOSE 1812/udp 1813/udp

# Use entrypoint script to wait for MySQL and configure host
ENTRYPOINT ["/docker-entrypoint.sh"]


