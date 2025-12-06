-- 03_create_users.sql
ALTER SESSION SET CONTAINER = mon_28028_herve_microloanApproval_db;

-- Admin user (PDB-level admin)
CREATE USER mon_28028_herve_admin IDENTIFIED BY "mama"
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

GRANT DBA TO mon_28028_herve_admin;

-- Application user (least privilege for schema objects)
CREATE USER microloan_app IDENTIFIED BY "mama"
  DEFAULT TABLESPACE microloan_data
  TEMPORARY TABLESPACE microloan_temp
  QUOTA 500M ON microloan_data
  QUOTA 100M ON microloan_index;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE TO microloan_app;