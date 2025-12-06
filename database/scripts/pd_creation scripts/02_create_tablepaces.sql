-- 02_create_tablespaces.sql
ALTER SESSION SET CONTAINER = mon_28028_herve_microloanApproval_db;
PROMPT === Creating tablespaces in PDB mon_28028_herve_microloanApproval_db ===

-- DATA tablespace
CREATE TABLESPACE microloan_data
  DATAFILE 'C:\ORACLEXE\ORADATA\XE\microloan_data01.dbf'
  SIZE 300M
  AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;

-- INDEX tablespace
CREATE TABLESPACE microloan_index
  DATAFILE 'C:\ORACLEXE\ORADATA\XE\microloan_index01.dbf'
  SIZE 200M
  AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;

-- TEMPORARY tablespace
CREATE TEMPORARY TABLESPACE microloan_temp
  TEMPFILE 'C:\ORACLEXE\ORADATA\XE\microloan_temp01.dbf'
  SIZE 200M
  AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;