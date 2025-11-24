FROM freeradius/freeradius-server:latest

# Copy configuration files
COPY raddb/clients.conf /etc/freeradius/clients.conf
COPY raddb/mods-available/sql /etc/freeradius/mods-available/sql
COPY raddb/mods-config/sql/main/mysql/queries.conf /etc/freeradius/mods-config/sql/main/mysql/queries.conf
COPY raddb/radiusd.conf.d/logging.conf /etc/freeradius/radiusd.conf.d/logging.conf

# Enable SQL module
RUN ln -s /etc/freeradius/mods-available/sql /etc/freeradius/mods-enabled/sql

# Enable SQL in default site
RUN sed -i '/^#.*sql$/s/^#//' /etc/freeradius/sites-available/default

# Set permissions
RUN chmod 644 /etc/freeradius/clients.conf && \
    chmod 644 /etc/freeradius/mods-available/sql && \
    chmod 644 /etc/freeradius/radiusd.conf.d/logging.conf

EXPOSE 1812/udp 1813/udp

CMD ["radiusd", "-f"]
