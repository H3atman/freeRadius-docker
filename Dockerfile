FROM freeradius/freeradius-server:latest

# Copy configuration files
COPY raddb/clients.conf /etc/freeradius/clients.conf
COPY raddb/mods-config/files/authorize /etc/freeradius/mods-config/files/authorize
COPY raddb/radiusd.conf.d/logging.conf /etc/freeradius/radiusd.conf.d/logging.conf

# Set proper permissions
RUN chmod 644 /etc/freeradius/clients.conf && \
    chmod 644 /etc/freeradius/mods-config/files/authorize && \
    chmod 644 /etc/freeradius/radiusd.conf.d/logging.conf

# Expose RADIUS ports
EXPOSE 1812/udp 1813/udp

# Run in foreground (logs go to stdout via logging config)
CMD ["radiusd", "-f"]
