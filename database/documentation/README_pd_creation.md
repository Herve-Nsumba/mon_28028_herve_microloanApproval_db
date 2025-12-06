# Database Creation - mon_28028_herve_microloanApproval_db

## Overview

This folder contains scripts to create and configure the Oracle pluggable database for the Microloan Approval and Risk Evaluation System.

**PDB Name:** mon_28028_herve_microloanApproval_db  
**Admin:** mon_28028_herve_admin (password: mama)  
**App user:** microloan_app (password: mama)

## Important

- These scripts assume Oracle XE on Windows with data directory: `C:\ORACLEXE\ORADATA\XE\`
- Run as SYSDBA (SQL\*Plus or SQL Developer).
- Modify file paths or sizes if your environment differs.

## Scripts (run in this order)

1. `01_create_pdb.sql`
2. `02_create_tablespaces.sql`
3. `03_create_users.sql`
4. `04_set_memory_parameters.sql` (restart needed)
5. `05_enable_archivelog.sql` (careful, sets ARCHIVELOG)
6. `06_verification_checks.sql`

## How to run

Connect as SYSDBA:

```bash
sqlplus / as sysdba
@01_create_pdb.sql
@02_create_tablespaces.sql
@03_create_users.sql
-- apply memory changes then restart instance
@04_set_memory_parameters.sql
-- restart DB (SHUTDOWN / STARTUP)
@05_enable_archivelog.sql
@06_verification_checks.sql
```
