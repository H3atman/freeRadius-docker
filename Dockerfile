FROM freeradius/freeradius-server:latest

# Copy your configuration files INTO the image
COPY raddb/clients.conf /etc/freeradius/clients.conf
COPY raddb/mods-config/files/authorize /etc/freeradius/mods-config/files/authorize

# Set proper permissions
RUN chmod 644 /etc/freeradius/clients.conf && \
    chmod 644 /etc/freeradius/mods-config/files/authorize

# Expose RADIUS ports
EXPOSE 1812/udp 1813/udp

# Run FreeRADIUS
CMD ["radiusd", "-f"]
