SET SERVEROUTPUT ON
PROMPT === Creating PDB mon_28028_herve_microloanApproval_db ===

-- Create PDB
CREATE PLUGGABLE DATABASE mon_28028_herve_microloanApproval_db
  ADMIN USER mon_28028_herve_admin IDENTIFIED BY "mama"
  ROLES = (DBA)
  DEFAULT TABLESPACE users
  DATAFILE 'C:\ORACLEXE\ORADATA\XE\mon_28028_herve_microloanApproval_db_users01.dbf' SIZE 200M AUTOEXTEND ON NEXT 50M
  FILE_NAME_CONVERT = ('C:\ORACLEXE\ORADATA\XE\pdbseed', 'C:\ORACLEXE\ORADATA\XE\mon_28028_herve_microloanApproval_db');

-- Open the PDB
ALTER PLUGGABLE DATABASE mon_28028_herve_microloanApproval_db OPEN;