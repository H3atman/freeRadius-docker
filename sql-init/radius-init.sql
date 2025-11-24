-- Add initial test users to FreeRADIUS
USE radius;

-- Insert test users into radcheck table
INSERT INTO radcheck (username, attribute, op, value) VALUES
('testuser', 'Cleartext-Password', ':=', 'password123'),
('bob', 'Cleartext-Password', ':=', 'hello'),
('wifi_user', 'Cleartext-Password', ':=', 'wifi_pass');

-- Insert NAS clients (MikroTik and localhost)
INSERT INTO nas (nasname, shortname, type, secret, description) VALUES
('127.0.0.1', 'localhost', 'other', 'testing123', 'Localhost RADIUS client'),
('192.168.88.1', 'mikrotik', 'other', 'testing123', 'MikroTik Router'),
('0.0.0.0/0', 'any', 'other', 'your_shared_secret_here', 'Any RADIUS client');
