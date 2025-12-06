-- 05_enable_archivelog.sql
SHUTDOWN IMMEDIATE;
-- Start up in MOUNT mode
STARTUP MOUNT;
-- Enable archivelog
ALTER DATABASE ARCHIVELOG;

-- Set archive destination (uses your ORACLE path)
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1='LOCATION=C:\ORACLEXE\ORADATA\XE\archivelog' SCOPE=SPFILE;

-- Open database
ALTER DATABASE OPEN;

-- Verify
ARCHIVE LOG LIST;

