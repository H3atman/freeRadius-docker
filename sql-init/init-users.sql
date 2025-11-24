USE radius;

-- Insert test users
INSERT INTO radcheck (username, attribute, op, value) VALUES
('testuser', 'Cleartext-Password', ':=', 'password123'),
('bob', 'Cleartext-Password', ':=', 'hello'),
('wifi_user', 'Cleartext-Password', ':=', 'wifi_pass');

-- Insert NAS clients
INSERT INTO nas (nasname, shortname, type, secret, description) VALUES
('127.0.0.1', 'localhost', 'other', 'testing123', 'Localhost'),
('192.168.88.1', 'mikrotik', 'other', 'testing123', 'MikroTik Router'),
('0.0.0.0/0', 'any', 'other', 'testing123', 'Any client');
EOF
