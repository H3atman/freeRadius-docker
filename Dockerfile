FROM freeradius/freeradius-server:latest

# Copy configuration files INTO the image
COPY raddb/clients.conf /etc/freeradius/clients.conf
COPY raddb/mods-config/files/authorize /etc/freeradius/mods-config/files/authorize
COPY raddb/radiusd.conf.d/logging.conf /etc/freeradius/radiusd.conf.d/logging.conf
COPY raddb/mods-config/sql/default /etc/freeradius/mods-available/sql

# Enable SQL module (symlinks already exist in image)
RUN ln -sf /etc/freeradius/mods-available/sql /etc/freeradius/mods-enabled/sql && \
    ln -sf /etc/freeradius/mods-available/sqlcounter /etc/freeradius/mods-enabled/sqlcounter

# Set proper permissions
RUN chmod 644 /etc/freeradius/clients.conf && \
    chmod 644 /etc/freeradius/mods-config/files/authorize && \
    chmod 644 /etc/freeradius/radiusd.conf.d/logging.conf

# Expose RADIUS ports
EXPOSE 1812/udp 1813/udp

# Run in foreground
CMD ["radiusd", "-X", "-f"]


