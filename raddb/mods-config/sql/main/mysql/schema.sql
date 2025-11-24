-- FreeRADIUS MySQL Schema

CREATE TABLE IF NOT EXISTS radacct (
  RadAcctId BIGINT(21) NOT NULL AUTO_INCREMENT,
  AcctSessionId VARCHAR(64) NOT NULL,
  AcctUniqueId VARCHAR(32),
  UserName VARCHAR(64),
  GroupName VARCHAR(64),
  Realm VARCHAR(64),
  NASIPAddress VARCHAR(15) NOT NULL,
  NASPortId VARCHAR(15),
  NASPortType VARCHAR(32),
  AcctStartTime DATETIME,
  AcctStopTime DATETIME,
  AcctSessionTime INT(12),
  AcctAuthentic VARCHAR(32),
  ConnectInfo_start VARCHAR(50),
  ConnectInfo_stop VARCHAR(50),
  AcctInputOctets BIGINT(20),
  AcctOutputOctets BIGINT(20),
  CalledStationId VARCHAR(50),
  CallingStationId VARCHAR(50),
  AcctTerminateCause VARCHAR(32),
  ServiceType VARCHAR(32),
  FramedProtocol VARCHAR(32),
  FramedIPAddress VARCHAR(15),
  FramedIPv6Address VARCHAR(45),
  FramedIPv6Prefix VARCHAR(3),
  FramedInterfaceId VARCHAR(44),
  DelegatedIPv6Prefix VARCHAR(45),
  CLASS VARCHAR(64),
  PRIMARY KEY (RadAcctId),
  KEY UserName (UserName),
  KEY AcctSessionId (AcctSessionId),
  KEY AcctUniqueId (AcctUniqueId),
  KEY FramedIPAddress (FramedIPAddress),
  KEY FramedIPv6Address (FramedIPv6Address),
  KEY GroupName (GroupName),
  KEY NASIPAddress (NASIPAddress),
  KEY AcctStartTime (AcctStartTime),
  KEY AcctStopTime (AcctStopTime)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS radcheck (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL,
  attribute VARCHAR(64) NOT NULL,
  op CHAR(2) NOT NULL DEFAULT ':=',
  value VARCHAR(253) NOT NULL,
  PRIMARY KEY (id),
  KEY username (username)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS radreply (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL,
  attribute VARCHAR(64) NOT NULL,
  op CHAR(2) NOT NULL DEFAULT '=',
  value VARCHAR(253) NOT NULL,
  PRIMARY KEY (id),
  KEY username (username)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS radusergroup (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL,
  groupname VARCHAR(64) NOT NULL,
  priority INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  KEY username (username)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS radgroupreply (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  groupname VARCHAR(64) NOT NULL,
  attribute VARCHAR(64) NOT NULL,
  op CHAR(2) NOT NULL DEFAULT '=',
  value VARCHAR(253) NOT NULL,
  PRIMARY KEY (id),
  KEY groupname (groupname)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS radgroupcheck (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  groupname VARCHAR(64) NOT NULL,
  attribute VARCHAR(64) NOT NULL,
  op CHAR(2) NOT NULL DEFAULT ':=',
  value VARCHAR(253) NOT NULL,
  PRIMARY KEY (id),
  KEY groupname (groupname)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS radpostauth (
  id BIGINT(21) NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL,
  pass VARCHAR(64) NOT NULL,
  reply VARCHAR(32) NOT NULL,
  CalledStationId VARCHAR(50),
  CallingStationId VARCHAR(50),
  authdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY username (username),
  KEY authdate (authdate)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS nas (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  nasname VARCHAR(128) NOT NULL,
  shortname VARCHAR(32) NOT NULL,
  type VARCHAR(30) NOT NULL DEFAULT 'other',
  ports INT(5),
  secret VARCHAR(60) NOT NULL,
  server VARCHAR(64),
  community VARCHAR(50),
  description VARCHAR(200),
  PRIMARY KEY (id),
  UNIQUE KEY nasname (nasname)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;
EOF
